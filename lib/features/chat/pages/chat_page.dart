import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../models/chat_message.dart';

import '../../../core/widgets/fintrack_top_bar.dart';

class ChatPage extends StatefulWidget {
  final VoidCallback onMenuTap;
  const ChatPage({super.key, required this.onMenuTap});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _scrollController = ScrollController();
  bool _hideHeroAndSuggestions = false;

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

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    context.read<ChatBloc>().add(MessageSent(text));
    setState(() {
      _hideHeroAndSuggestions = true;
    });
    // FocusScope.of(context).unfocus(); // keep keyboard open perhaps? Or unfocus. Prompt doesn't specify unfocusing. Let's keep it fluid.
    _scrollToBottom();
  }

  void _fillInput(String text) {
    setState(() {
      _controller.text = text;
      _hideHeroAndSuggestions = true;
    });
    _focusNode.requestFocus();
  }

  bool get _hasText => _controller.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: FinTrackTopBar(
        title: 'FinTrack AI',
        onMenuTap: widget.onMenuTap,
        action: GestureDetector(
          onTap: () {
            context.read<ChatBloc>().add(ChatCleared());
            setState(() {
              _hideHeroAndSuggestions = false;
            });
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: AppColors.card,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(14)),
            child: const Center(
              child:
                  Icon(Icons.delete_outline, size: 20, color: AppColors.ink2),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state.messages.isNotEmpty && !_hideHeroAndSuggestions) {
                  setState(() => _hideHeroAndSuggestions = true);
                }
                _scrollToBottom();
              },
              builder: (context, state) {
                final messages = state.messages;
                final showHero = messages.isEmpty && !_hideHeroAndSuggestions;

                return ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(bottom: 20),
                  children: [
                    if (showHero) ...[
                      _buildHeroArea(context),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _buildSuggestions(),
                      ),
                    ],
                    ...messages.map((m) => _MessageBubble(message: m)),
                    if (state is ChatProcessing)
                      const Padding(
                        padding: EdgeInsets.only(left: 16, top: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Typing...',
                              style: TextStyle(
                                  color: AppColors.ink3, fontSize: 12)),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildHeroArea(BuildContext context) {
    // Get from DashboardBloc / FinancialProfileBloc ideally. Using static as per prompt.
    const balance = 13700.0;
    const spent = 1300.0;
    const streak = 7;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting
          RichText(
              text: TextSpan(
                  style: GoogleFonts.sora(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.8,
                      color: AppColors.ink),
                  children: [
                const TextSpan(text: 'Good morning, '),
                WidgetSpan(
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF5B2EFF), Color(0xFFFF3B5C)],
                    ).createShader(bounds),
                    child: Text('how can I help?',
                        style: GoogleFonts.sora(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.8,
                            color: Colors.white)),
                  ),
                ),
              ])),
          const SizedBox(height: 4),
          Text('Tell me what you spent, or ask about your money.',
              style: GoogleFonts.inter(fontSize: 13, color: AppColors.ink3)),
          const SizedBox(height: 20),
          // ── 3 quick stat cards ──
          Row(children: [
            _QuickCard(
                emoji: '💰',
                value: '₹${balance.toInt()}',
                label: 'Balance left',
                onTap: () => _fillInput('What is my balance?')),
            const SizedBox(width: 8),
            _QuickCard(
                emoji: '📊',
                value: '₹${spent.toInt()}',
                label: 'Spent so far',
                onTap: () => _fillInput('How much did I spend this month?')),
            const SizedBox(width: 8),
            _QuickCard(
                emoji: '🔥',
                value: '$streak days',
                label: 'Streak',
                isDark: true,
                onTap: () => _fillInput('What is my streak?')),
          ]),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
    final items = [
      ('🍔', '#FFF3E0', 'Spent 400 on Swiggy'),
      ('⛽', '#E8F5E9', 'Paid 1200 for petrol'),
      ('💰', '#EDE7F6', 'What is my balance?'),
      ('⚠️', '#FCE4EC', 'Am I over budget?'),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 6),
          child: Text('TRY SAYING',
              style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: AppColors.ink3))),
      ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: _SugChip(
            emoji: item.$1,
            bgHex: item.$2,
            text: item.$3,
            onTap: () => _fillInput(item.$3),
          ))),
    ]);
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
      decoration: const BoxDecoration(
          color: AppColors.bg,
          border: Border(top: BorderSide(color: AppColors.border))),
      child: Row(children: [
        // Camera button
        GestureDetector(
          onTap: () => context.read<ChatBloc>().add(ReceiptScanRequested()),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: AppColors.card,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(14)),
            child: const Center(
              child: Icon(Icons.camera_alt_outlined,
                  size: 20, color: AppColors.ink2),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Text field
        Expanded(
            child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: (t) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'Type expense or ask anything...',
            hintStyle: GoogleFonts.inter(fontSize: 14, color: AppColors.ink3),
            filled: true,
            fillColor: AppColors.card,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide:
                    const BorderSide(color: AppColors.border, width: 1.5)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide:
                    const BorderSide(color: AppColors.violet, width: 1.5)),
          ),
          style: GoogleFonts.inter(fontSize: 14, color: AppColors.ink),
        )),
        const SizedBox(width: 8),
        // Send button
        GestureDetector(
          onTap: _hasText ? _send : null,
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                  color: _hasText ? AppColors.ink : AppColors.border,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: _hasText
                      ? [
                          const BoxShadow(
                              color: Color(0x4D0C0C14),
                              blurRadius: 20,
                              offset: Offset(0, 6))
                        ]
                      : []),
              child: const Icon(Icons.arrow_upward_rounded,
                  color: Colors.white, size: 20)),
        ),
      ]),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.type == MessageType.error) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFEECEC),
              border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(5),
              ),
            ),
            child: Text(message.text,
                style: GoogleFonts.inter(fontSize: 14, color: Colors.red)),
          ),
        ),
      );
    }

    final isUser = message.type == MessageType.user;

    // Bot bubbles: white card, 1px border, borderRadius 20 bottomLeft 5
    // User bubbles: #0C0C14 bg, white text, borderRadius 20 bottomRight 5
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isUser ? AppColors.ink : AppColors.card,
            border:
                isUser ? null : Border.all(color: AppColors.border, width: 1),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: Radius.circular(isUser ? 20 : 5),
              bottomRight: Radius.circular(isUser ? 5 : 20),
            ),
          ),
          child: Text(
            message.text,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: isUser ? Colors.white : AppColors.ink,
              height: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickCard extends StatelessWidget {
  final String emoji, value, label;
  final bool isDark;
  final VoidCallback onTap;
  const _QuickCard(
      {required this.emoji,
      required this.value,
      required this.label,
      this.isDark = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) => Expanded(
      child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: isDark ? AppColors.ink : AppColors.card,
                border: Border.all(
                    color: isDark ? AppColors.ink : AppColors.border),
                borderRadius: BorderRadius.circular(16)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 6),
              Text(value,
                  style: GoogleFonts.sora(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : AppColors.ink)),
              Text(label,
                  style: GoogleFonts.inter(
                      fontSize: 11,
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.4)
                          : AppColors.ink3)),
            ]),
          )));
}

class _SugChip extends StatelessWidget {
  final String emoji, bgHex, text;
  final VoidCallback onTap;
  const _SugChip(
      {required this.emoji,
      required this.bgHex,
      required this.text,
      required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
            color: AppColors.card,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                  color: Color(int.parse(bgHex.replaceFirst('#', '0xFF'))),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(emoji, style: const TextStyle(fontSize: 15)))),
          const SizedBox(width: 10),
          Expanded(
              child: Text(text,
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.ink2))),
          const Text('›',
              style: TextStyle(fontSize: 18, color: AppColors.ink3)),
        ]),
      ));
}
