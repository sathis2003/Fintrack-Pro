import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../widgets/message_bubble.dart';
import '../widgets/typing_indicator.dart';
import '../widgets/category_suggestion_chip.dart';
import '../../../../core/widgets/gradient_button.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    context.read<ChatBloc>().add(MessageSent(text));
    FocusScope.of(context).unfocus();
    _scrollToBottom();
  }

  void _showConfirmationSheet(
      BuildContext context, ChatAwaitingConfirmation state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        final expense = state.extracted;
        final theme = Theme.of(context);
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(bottomSheetContext).padding.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Confirm Expense',
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                '₹${expense.amount.toStringAsFixed(0)}',
                style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                expense.description,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Center(
                child: Chip(
                  label: Text('Category: ${expense.category}'),
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  expense.date,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(bottomSheetContext);
                        context.read<ChatBloc>().add(ExpenseRejected());
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: GradientButton(
                      label: 'Save Expense',
                      icon: Icons.check,
                      onPressed: () {
                        Navigator.pop(bottomSheetContext);
                        context.read<ChatBloc>().add(ExpenseConfirmed(expense));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      // If bottom sheet is dismissed by tapping outside, consider it rejected
      final bloc = context.read<ChatBloc>();
      if (bloc.state is ChatAwaitingConfirmation) {
        bloc.add(ExpenseRejected());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          LottieBuilder.asset(
            'assets/lottie/ai_chat_bot.json',
            width: 180,
            height: 180,
            repeat: true,
            errorBuilder: (_, __, ___) => Container(
              width: 110,
              height: 110,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2D1B69), Color(0xFF6C2BD9)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.auto_awesome_rounded,
                  color: Colors.white, size: 44),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'FinTrack AI',
            style: GoogleFonts.sora(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Your personal finance assistant',
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 28),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outline, width: 0.5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.5),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Color(0xFF6C2BD9), width: 4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.tips_and_updates_rounded,
                            color: Color(0xFF6C2BD9), size: 16),
                        const SizedBox(width: 6),
                        Text(
                          'Try saying...',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF6C2BD9),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...[
                      'Spent 400 on Swiggy',
                      'Paid 1,200 for petrol today',
                      'How much did I spend this month?',
                    ].map(
                      (hint) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            _controller.text = hint;
                            _controller.selection = TextSelection.fromPosition(
                                TextPosition(offset: hint.length));
                            _focusNode.requestFocus();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.arrow_forward_ios_rounded,
                                    size: 12, color: Color(0xFF6C2BD9)),
                                const SizedBox(width: 8),
                                Text(
                                  hint,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: Row(children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF6C2BD9), Color(0xFF00C2CB)]),
                shape: BoxShape.circle),
            child: const Icon(Icons.auto_awesome_rounded,
                color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'FinTrack ',
                    style: GoogleFonts.sora(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurface)),
                TextSpan(
                    text: 'AI',
                    style: GoogleFonts.sora(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF6C2BD9))),
              ])),
              Row(children: [
                Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                        color: Color(0xFF10B981), shape: BoxShape.circle)),
                const SizedBox(width: 4),
                Text('Online',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color: const Color(0xFF10B981),
                        fontWeight: FontWeight.w500)),
              ]),
            ],
          ),
        ]),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: () => context.read<ChatBloc>().add(ChatCleared()),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Message List ──────────────────
          Expanded(
            child: BlocConsumer<ChatBloc, ChatState>(
              listenWhen: (prev, curr) {
                return (curr is ChatAwaitingConfirmation &&
                        prev is! ChatAwaitingConfirmation) ||
                    (curr is ChatExpenseSaved && prev is! ChatExpenseSaved);
              },
              listener: (context, state) {
                if (state is ChatExpenseSaved) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Expense saved successfully!'),
                      backgroundColor: Color(0xFF10B981),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else if (state is ChatAwaitingConfirmation) {
                  _showConfirmationSheet(context, state);
                }
                _scrollToBottom();
              },
              builder: (context, state) {
                final messages = state.messages;

                if (messages.isEmpty) {
                  return _buildEmptyState(context);
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  itemCount:
                      messages.length + (state is ChatProcessing ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (state is ChatProcessing && index == messages.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TypingIndicator(),
                      );
                    }
                    return MessageBubble(message: messages[index]);
                  },
                );
              },
            ),
          ),

          // Category suggestion from Gemma
          BlocBuilder<ChatBloc, ChatState>(
            buildWhen: (prev, curr) =>
                curr is ChatCategorySuggested || prev is ChatCategorySuggested,
            builder: (context, state) {
              if (state is ChatCategorySuggested) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: CategorySuggestionChip(
                    category: state.suggestedCategory,
                    onTap: () {
                      final current = _controller.text.trim();
                      if (!current.contains(state.suggestedCategory)) {
                        _controller.text =
                            '$current (${state.suggestedCategory})';
                        _controller.selection = TextSelection.fromPosition(
                            TextPosition(offset: _controller.text.length));
                      }
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),

          // ── Input Bar ─────────────────────
          _ChatInputBar(
            controller: _controller,
            focusNode: _focusNode,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class _ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSend;

  const _ChatInputBar({
    required this.controller,
    required this.focusNode,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF14141F) : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? const Color(0xFF2D1B69) : const Color(0xFFE5E7EB),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(children: [
          // Camera
          GestureDetector(
            onTap: () => context.read<ChatBloc>().add(ReceiptScanRequested()),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color:
                    isDark ? const Color(0xFF1E1E2E) : const Color(0xFFEDE9FE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.camera_alt_outlined,
                  color: Color(0xFF6C2BD9), size: 20),
            ),
          ),
          const SizedBox(width: 10),
          // Text field
          Expanded(
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color:
                    isDark ? const Color(0xFF1E1E2E) : const Color(0xFFF4F0FF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF2D1B69)
                      : const Color(0xFFDDD6FE),
                ),
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                onSubmitted: (_) => onSend(),
                onChanged: (t) => context.read<ChatBloc>().add(TextChanged(t)),
                decoration: InputDecoration(
                  hintText: 'Type your expense...',
                  hintStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 15, color: const Color(0xFF9CA3AF)),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Send
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (_, val, __) {
              final hasText = val.text.trim().isNotEmpty;
              return GestureDetector(
                onTap: hasText ? onSend : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: hasText
                          ? [const Color(0xFF6C2BD9), const Color(0xFF8B5CF6)]
                          : [const Color(0xFFD1D5DB), const Color(0xFFD1D5DB)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: hasText
                        ? [
                            BoxShadow(
                              color: const Color(0xFF6C2BD9)
                                  .withValues(alpha: 0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            )
                          ]
                        : [],
                  ),
                  child: const Icon(Icons.arrow_upward_rounded,
                      color: Colors.white, size: 22),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
