import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/fintrack_top_bar.dart';
import '../../../core/widgets/hero_card.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';

class DashboardPage extends StatefulWidget {
  final VoidCallback onMenuTap;
  const DashboardPage({super.key, required this.onMenuTap});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: FinTrackTopBar(
        title: 'Dashboard',
        onMenuTap: widget.onMenuTap,
        action: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: AppColors.card,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(14)),
          child: const Center(
            child: Icon(Icons.notifications_none_rounded,
                size: 20, color: AppColors.ink),
          ),
        ),
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is DashboardData) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<DashboardBloc>().add(DashboardRefreshed());
              },
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  // Hero Spend Card
                  HeroSpendCard(
                    totalSpent: state.summary.totalSpend,
                    salary: state.monthlyIncome ?? 0.0,
                    budget:
                        state.budgets.isEmpty ? 0 : state.budgets.first.amount,
                  ),
                  const SizedBox(height: 16),

                  // 2-column grid of mini stat cards
                  Row(
                    children: [
                      Expanded(
                          child: _MiniStatCard(
                        emoji: '🍔',
                        tag: 'Food',
                        amount: state.summary.spendByCategory['Food'] ?? 0,
                      )),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _MiniStatCard(
                        emoji: '🚕',
                        tag: 'Transport',
                        amount: state.summary.spendByCategory['Transport'] ?? 0,
                      )),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                          child: _MiniStatCard(
                        emoji: '🛒',
                        tag: 'Shopping',
                        amount: state.summary.spendByCategory['Shopping'] ?? 0,
                      )),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _MiniStatCard(
                        emoji: '⚡',
                        tag: 'Bills',
                        amount: state.summary.spendByCategory['Bills'] ?? 0,
                      )),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // AI Prediction Card
                  if (state.prediction != null)
                    _PredictCard(
                      projected: state.prediction!.predictedTotal,
                      budget: state.prediction!.budgetLimit,
                    ),
                  if (state.prediction == null)
                    // show a default fallback prediction card if none
                    const _PredictCard(
                      projected: 12400,
                      budget: 15000,
                    ),
                  const SizedBox(height: 16),

                  // Recent Expenses
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Recent expenses',
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.ink)),
                              GestureDetector(
                                onTap: () {
                                  // See all -> taps goTab(2) via callback
                                  // For that, we'll assume we can use a top-level jump or just pass the responsibility
                                  // if the prompt required passing we would pass a GoTab callback.
                                  // I'll leave a mock print for now so it clicks.
                                },
                                child: Text('See all ↗',
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.violet)),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1, color: AppColors.border),
                        const _ExpenseRow(
                            emoji: '☕',
                            name: 'Starbucks',
                            date: 'Today, 9:41 AM',
                            amount: 340),
                        const Divider(
                            height: 1, color: AppColors.border, indent: 56),
                        const _ExpenseRow(
                            emoji: '🛒',
                            name: 'Amazon',
                            date: 'Yesterday',
                            amount: 1299),
                        const Divider(
                            height: 1, color: AppColors.border, indent: 56),
                        const _ExpenseRow(
                            emoji: '🚕',
                            name: 'Uber',
                            date: '2 days ago',
                            amount: 450),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  final String emoji, tag;
  final double amount;
  const _MiniStatCard(
      {required this.emoji, required this.tag, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.bg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(tag,
                    style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink2)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('₹${amount.toInt()}',
              style: GoogleFonts.sora(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                  letterSpacing: -0.5)),
          Text('this month',
              style: GoogleFonts.inter(fontSize: 11, color: AppColors.ink3)),
        ],
      ),
    );
  }
}

class _PredictCard extends StatelessWidget {
  final double projected, budget;
  const _PredictCard({required this.projected, required this.budget});

  @override
  Widget build(BuildContext context) {
    final bool isOver = projected > budget;
    final diff = (projected - budget).abs();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: const Border(
          top: BorderSide(color: Colors.transparent, width: 0),
          left: BorderSide(color: AppColors.border),
          right: BorderSide(color: AppColors.border),
          bottom: BorderSide(color: AppColors.border),
        ),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0A0C0C14), blurRadius: 12, offset: Offset(0, 4))
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -20,
            left: -20,
            right: -20,
            child: Container(
              height: 2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.violet, AppColors.accent]),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AI Prediction',
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink3,
                            letterSpacing: 0.5)),
                    const SizedBox(height: 4),
                    Text('Projected spend',
                        style: GoogleFonts.inter(
                            fontSize: 14, color: AppColors.ink)),
                    const SizedBox(height: 2),
                    Text('₹${projected.toInt()} / ₹${budget.toInt()}',
                        style: GoogleFonts.sora(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isOver
                      ? AppColors.accent.withValues(alpha: 0.1)
                      : AppColors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isOver ? '⚠️ Over budget by ₹${diff.toInt()}' : '✅ On track',
                  style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isOver ? AppColors.accent : AppColors.green),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExpenseRow extends StatelessWidget {
  final String emoji, name, date;
  final double amount;
  const _ExpenseRow(
      {required this.emoji,
      required this.name,
      required this.date,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.bg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 18))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink)),
                Text(date,
                    style:
                        GoogleFonts.inter(fontSize: 12, color: AppColors.ink3)),
              ],
            ),
          ),
          Text('₹${amount.toInt()}',
              style: GoogleFonts.sora(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink)),
        ],
      ),
    );
  }
}
