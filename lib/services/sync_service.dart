import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:injectable/injectable.dart';
import '../core/constants/app_constants.dart';
import '../core/network/connectivity_service.dart';
import '../core/utils/logger.dart';
import '../data/local/daos/sync_queue_dao.dart';
import '../data/remote/supabase_expense_source.dart';
import '../data/remote/supabase_budget_source.dart';
import '../data/local/daos/raw_expenses_dao.dart';
import '../domain/use_cases/extract_expense_from_text.dart';
import '../domain/use_cases/add_expense.dart';
import '../data/mappers/expense_mapper.dart';
import 'package:uuid/uuid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@singleton
class SyncService {
  final SyncQueueDao _queueDao;
  final SupabaseExpenseSource _expenseSource;
  final SupabaseBudgetSource _budgetSource;
  final ConnectivityService _connectivity;
  final RawExpensesDao _rawExpensesDao;
  final ExtractExpenseFromText _extractUseCase;
  final AddExpense _addUseCase;
  final SupabaseClient _supabase;

  StreamSubscription<bool>? _sub;
  bool _isSyncing = false;

  SyncService(
    this._queueDao,
    this._expenseSource,
    this._budgetSource,
    this._connectivity,
    this._rawExpensesDao,
    this._extractUseCase,
    this._addUseCase,
    this._supabase,
  );

  void start() {
    _sub = _connectivity.onlineStream.listen((isOnline) {
      if (isOnline && !_isSyncing) {
        drainQueue();
      }
    });
  }

  Future<void> drainQueue() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final pending = await _queueDao.getAllPending();
      if (pending.isEmpty) return;

      AppLogger.i('SyncService', 'Draining ${pending.length} pending ops');

      for (final op in pending) {
        // Skip if too many retries (max 5)
        if (op.retryCount >= AppConstants.maxSyncRetries) continue;

        // NEW: exponential backoff — don't retry too fast
        final backoffMinutes = pow(2, op.retryCount).toInt(); // 1,2,4,8,16 min
        final createdAtDate = DateTime.fromMillisecondsSinceEpoch(op.createdAt);
        final nextRetry = createdAtDate.add(Duration(minutes: backoffMinutes));

        if (DateTime.now().isBefore(nextRetry)) {
          AppLogger.i('SyncService',
              'Backoff active for ${op.id}. Next retry at $nextRetry');
          continue;
        }

        try {
          final isExpense = op.tableIdentifier == 'expenses';
          final isBudget = op.tableIdentifier == 'budgets';

          switch (op.operation) {
            case 'insert':
            case 'update':
            case 'upsert':
              final payload = jsonDecode(op.payload) as Map<String, dynamic>;
              if (isExpense) await _expenseSource.upsert(payload);
              if (isBudget) await _budgetSource.upsert(payload);
              break;
            case 'delete':
              if (isExpense) await _expenseSource.softDelete(op.recordUuid);
              if (isBudget) await _budgetSource.delete(op.recordUuid);
              break;
          }
          // Success — remove from queue
          await _queueDao.deleteById(op.id);
          AppLogger.i('SyncService',
              'Synced: ${op.tableIdentifier} ${op.operation} ${op.recordUuid}');
        } catch (e, stackTrace) {
          AppLogger.e('SyncService', 'Sync failed for ${op.id}', e);
          await _queueDao.incrementRetry(op.id);

          await Sentry.captureException(
            e,
            stackTrace: stackTrace,
            hint: Hint.withMap({
              'context': 'sync_queue_item_failed',
              'table': op.tableIdentifier,
              'operation': op.operation,
              'retry_count': op.retryCount.toString(),
            }),
          );
        }
      }

      // Process raw expenses (AI Sync)
      await _processRawExpenses();
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _processRawExpenses() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    final pendingRaw = await _rawExpensesDao.getAllPending(userId);
    if (pendingRaw.isEmpty) return;

    AppLogger.i('SyncService', 'Processing ${pendingRaw.length} raw expenses');

    for (final raw in pendingRaw) {
      final result = await _extractUseCase(raw.rawText);
      await result.fold(
        (failure) async {
          AppLogger.w(
              'SyncService', 'AI Sync failed for raw text: ${raw.rawText}');
        },
        (extracted) async {
          if (extracted.hasExpense) {
            final expense = ExpenseMapper.fromExtracted(
              extracted,
              userId,
              const Uuid().v4(),
            );
            await _addUseCase(expense);
            AppLogger.i(
                'SyncService', 'AI Sync success: ${expense.description}');
          }
          await _rawExpensesDao.deleteRaw(raw.id);
        },
      );
    }
  }

  void dispose() => _sub?.cancel();
}
