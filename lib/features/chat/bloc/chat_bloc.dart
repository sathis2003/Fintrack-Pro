import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'chat_event.dart';
import 'chat_state.dart';
import '../models/chat_message.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/use_cases/extract_expense_from_text.dart';
import '../../../domain/use_cases/add_expense.dart';
import '../../../data/mappers/expense_mapper.dart';
import '../../../data/local/daos/financial_profile_dao.dart';
import '../../../data/local/daos/expenses_dao.dart';
import '../../../data/local/daos/raw_expenses_dao.dart';
import '../../../data/local/database/app_database.dart';
import '../../../services/achievement_service.dart';
import 'dart:async';
import '../../../services/gemma_model_service.dart';
import '../../../services/gemma_analysis_service.dart';

import '../../../services/camera_service.dart';
import '../../../domain/repositories/i_ai_repository.dart';
import '../../../services/chat_context_builder.dart';
import '../../../data/repositories/ai_repository_impl.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ExtractExpenseFromText _extractUseCase;
  final IAiRepository _aiRepository;
  final AddExpense _addUseCase;
  final SupabaseClient _supabase;
  final FinancialProfileDao _profileDao;
  final AchievementService _achievementService;
  final ExpensesDao _expensesDao;
  final RawExpensesDao _rawExpensesDao;
  final ChatContextBuilder _contextBuilder;
  final List<ChatMessage> _messages = [];
  DateTime? _lastAiCallTime;
  Timer? _categorySuggestionTimer;

  ChatBloc(
    this._extractUseCase,
    this._aiRepository,
    this._addUseCase,
    this._supabase,
    this._profileDao,
    this._achievementService,
    this._expensesDao,
    this._rawExpensesDao,
    this._contextBuilder,
  ) : super(const ChatIdle()) {
    on<MessageSent>(_onMessageSent);
    on<ExpenseConfirmed>(_onExpenseConfirmed);
    on<ExpenseRejected>(_onExpenseRejected);
    on<ChatCleared>(_onChatCleared);
    on<TextChanged>(_onTextChanged);
    on<ReceiptScanRequested>(_onReceiptScanRequested);
    on<ReceiptScanCompleted>(_onReceiptScanCompleted);
  }

  Future<void> _onMessageSent(
      MessageSent event, Emitter<ChatState> emit) async {
    // ── Rate limiting (keep existing) ────────────────────────
    final now = DateTime.now();
    if (_lastAiCallTime != null &&
        now.difference(_lastAiCallTime!).inSeconds < 2) return;
    _lastAiCallTime = now;

    _messages.add(ChatMessage.user(event.text));
    emit(ChatProcessing(messages: List.from(_messages)));

    // ── Call AI to extract intent and data ──────────────────────
    final result = await _extractUseCase(event.text);

    await result.fold(
      (failure) async {
        String message;
        if (failure is RateLimitFailure) {
          message = 'You are sending too fast. Please wait a moment.';
        } else if (failure is NetworkFailure || failure is AIFailure) {
          final uid = _supabase.auth.currentUser?.id;
          if (uid != null) {
            await _rawExpensesDao.insertRaw(RawExpensesCompanion.insert(
              userId: uid,
              rawText: event.text,
              createdAt: DateTime.now().millisecondsSinceEpoch,
            ));
            message = 'Connection issue. Queued for sync.';
          } else {
            message = 'Network error. Please try again.';
          }
        } else {
          message = 'Something went wrong. Please try again.';
        }
        _messages.add(ChatMessage.error(message));
        emit(ChatError(messages: List.from(_messages), errorMessage: message));
      },
      (extracted) async {
        // ── Handle greeting ───────────────────────────────
        if (extracted.intent == 'greeting') {
          _messages.add(ChatMessage.bot(
            'Hi! 👋 I am FinTrack AI.\n'
            'Tell me what you spent — e.g. "Spent 450 on Swiggy" — '
            'or ask me anything about your finances!',
          ));
          emit(ChatIdle(messages: List.from(_messages)));
          return;
        }

        // ── Handle financial questions ───────────────────
        if (extracted.intent == 'question' ||
            (!extracted.hasExpense && extracted.intent != 'expense')) {
          final userId = _supabase.auth.currentUser?.id;
          if (userId == null) {
            _messages.add(ChatMessage.error('Please log in first.'));
            emit(ChatError(
                messages: List.from(_messages), errorMessage: 'Not logged in'));
            return;
          }

          try {
            // Fetch real data from Drift
            final context = await _contextBuilder.build(userId);

            // Get conversational answer from Groq
            final answer = await (_aiRepository as AiRepositoryImpl)
                .source
                .answerQuestion(event.text, context);

            _messages.add(ChatMessage.bot(answer));
            emit(ChatIdle(messages: List.from(_messages)));
          } catch (e) {
            _messages.add(ChatMessage.error(
                'Could not get your financial data. Please try again.'));
            emit(ChatError(
                messages: List.from(_messages), errorMessage: e.toString()));
          }
          return;
        }

        // ── Handle expense entry ─────────────────────────
        if (!extracted.hasExpense) {
          _messages.add(ChatMessage.bot(
            "I couldn't catch that. 🤔\n\n"
            "To add an expense, try:\n"
            "• 'Spent 500 on food'\n"
            "• 'Paid 1200 for petrol'\n"
            "• 'Coffee 80'\n\n"
            "To ask about your finances, try:\n"
            "• 'How much have I spent this month?'\n"
            "• 'What is my balance?'",
          ));
          emit(ChatNoExpenseFound(messages: List.from(_messages)));
          return;
        }

        emit(ChatAwaitingConfirmation(
          messages: List.from(_messages),
          extracted: extracted,
        ));
      },
    );
  }

  Future<void> _onExpenseConfirmed(
      ExpenseConfirmed event, Emitter<ChatState> emit) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      emit(ChatError(
        messages: List.from(_messages),
        errorMessage: 'You must be logged in to save expenses.',
      ));
      return;
    }

    const uuid = Uuid();
    final expense =
        ExpenseMapper.fromExtracted(event.expense, userId, uuid.v4());

    final result = await _addUseCase(expense);

    await result.fold(
      (failure) async {
        _messages.add(ChatMessage.error('Could not save: ${failure.message}'));

        await Sentry.captureException(
          failure,
          hint: Hint.withMap({
            'context': 'chat_expense_save_failed',
            'expense_uuid': expense.uuid,
            'user_id': userId,
          }),
        );

        emit(ChatError(
          messages: List.from(_messages),
          errorMessage: failure.message,
        ));
      },
      (saved) async {
        _messages.add(ChatMessage.bot(
          'Saved ${saved.category} expense of '
          'Rs ${saved.amount.toStringAsFixed(0)}',
        ));

        // Phase 4: Streak and Achievements
        await _profileDao.updateStreak(userId);
        final totalCount = await _expensesDao.getTotalCount(userId);
        final profile = await _profileDao.getByUser(userId);

        final newBadges = await _achievementService.checkAfterExpenseSave(
          totalExpenseCount: totalCount,
          currentStreakDays: profile?.currentStreak ?? 0,
        );

        if (newBadges.isNotEmpty) {
          emit(ChatBadgeUnlocked(
            badgeId: newBadges.first,
            messages: List.from(_messages),
          ));
        } else {
          emit(ChatExpenseSaved(messages: List.from(_messages)));
        }
      },
    );
  }

  void _onExpenseRejected(ExpenseRejected event, Emitter<ChatState> emit) {
    _messages.add(ChatMessage.bot(
      'No problem. Tell me the correct amount or description.',
    ));
    emit(ChatIdle(messages: List.from(_messages)));
  }

  void _onChatCleared(ChatCleared event, Emitter<ChatState> emit) {
    _messages.clear();
    emit(const ChatIdle());
  }

  void _onTextChanged(TextChanged event, Emitter<ChatState> emit) {
    _categorySuggestionTimer?.cancel();
    if (event.text.length < 8) return;
    if (!GemmaModelService.isReady.value) return;

    _categorySuggestionTimer =
        Timer(const Duration(milliseconds: 600), () async {
      final prompt = GemmaAnalysisService.categoryPrompt(event.text);
      final suggestion = await GemmaModelService.generateSync(prompt);
      if (suggestion.isEmpty) return;
      final clean = suggestion.trim().split('\n').first.trim();

      final validCategories = [
        'Food',
        'Transport',
        'Shopping',
        'Bills',
        'Health',
        'Entertainment',
        'Education',
        'Investment',
        'Other',
      ];
      if (validCategories.contains(clean)) {
        emit(ChatCategorySuggested(
          messages: List.from(_messages),
          suggestedCategory: clean,
        ));
      }
    });
  }

  Future<void> _onReceiptScanRequested(
      ReceiptScanRequested event, Emitter<ChatState> emit) async {
    final base64 = await CameraService.captureReceipt();
    if (base64 == null) return; // user cancelled

    _messages.add(ChatMessage.bot('📷 Scanning receipt...'));
    emit(ChatProcessing(messages: List.from(_messages)));
    add(ReceiptScanCompleted(base64));
  }

  Future<void> _onReceiptScanCompleted(
      ReceiptScanCompleted event, Emitter<ChatState> emit) async {
    final result = await _aiRepository.scanReceipt(event.base64Image);
    result.fold(
      (failure) {
        final msg = failure is ParseFailure
            ? 'That does not look like a receipt. Please try a clearer photo.'
            : 'Could not read the receipt. Please try again.';
        _messages.add(ChatMessage.error(msg));
        emit(ChatError(messages: List.from(_messages), errorMessage: msg));
      },
      (extracted) {
        emit(ChatAwaitingConfirmation(
          messages: List.from(_messages),
          extracted: extracted,
        ));
      },
    );
  }
}
