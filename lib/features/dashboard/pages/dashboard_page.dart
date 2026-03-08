import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:intl/intl.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/spend_summary_card.dart';
import '../widgets/category_donut_chart.dart';
import '../widgets/daily_bar_chart.dart';
import '../widgets/budget_progress_row.dart';
import '../widgets/predictions_card.dart';
import '../widgets/gemma_insight_chip.dart';
import '../../../../core/theme/theme_notifier.dart';
import '../../../../core/di/injection.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/empty_state.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  ISentrySpan? _transaction;

  @override
  void initState() {
    super.initState();
    _transaction = Sentry.startTransaction('dashboard.load', 'ui.load');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: GoogleFonts.sora(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              getIt<ThemeNotifier>().isDark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              color: const Color(0xFF6C2BD9),
            ),
            onPressed: () {
              getIt<ThemeNotifier>().toggle();
            },
            tooltip: 'Toggle Theme',
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: BlocListener<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardData) {
            _transaction?.finish(status: const SpanStatus.ok());
            _transaction = null;
          }
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
          buildWhen: (prev, curr) => prev != curr,
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is DashboardError) {
              return Center(child: Text(state.message));
            }

            if (state is DashboardData) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<DashboardBloc>().add(DashboardRefreshed());
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            children: [
                              Text(
                                DateFormat('MMMM yyyy')
                                    .format(state.currentMonth),
                                style: GoogleFonts.sora(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  final prev = DateTime(state.currentMonth.year,
                                      state.currentMonth.month - 1);
                                  context
                                      .read<DashboardBloc>()
                                      .add(DashboardMonthChanged(prev));
                                },
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6C2BD9)
                                        .withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.chevron_left_rounded,
                                    color: Color(0xFF6C2BD9),
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  final next = DateTime(state.currentMonth.year,
                                      state.currentMonth.month + 1);
                                  context
                                      .read<DashboardBloc>()
                                      .add(DashboardMonthChanged(next));
                                },
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6C2BD9)
                                        .withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.chevron_right_rounded,
                                    color: Color(0xFF6C2BD9),
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Hero Spend Card
                        SpendSummaryCard(
                          summary: state.summary,
                          monthlyIncome: state.monthlyIncome,
                        ),
                        const SizedBox(height: 16),

                        const GemmaInsightChip(),
                        const SizedBox(height: 16),

                        if (state.prediction != null) ...[
                          PredictionsCard(prediction: state.prediction!),
                          const SizedBox(height: 24),
                        ],

                        Text('Category Distribution',
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 16),
                        if (state.summary.spendByCategory.isEmpty)
                          EmptyState(
                            lottiePath: 'assets/lottie/chart_empty.json',
                            title: 'No spending yet',
                            subtitle:
                                'Add expenses in Chat to see your category breakdown.',
                            action: ElevatedButton.icon(
                              icon: const Icon(Icons.add_rounded),
                              label: const Text('Add Expense'),
                              onPressed: () => context.go('/chat'),
                            ),
                          )
                        else
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: CategoryDonutChart(
                                  categoryData: state.summary.spendByCategory),
                            ),
                          ),
                        const SizedBox(height: 24),

                        Text('Daily Spending',
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 16),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: DailyBarChart(
                                dailyData: state.summary.dailySpend),
                          ),
                        ),
                        const SizedBox(height: 24),

                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Budgets',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text('Set Limits'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                if (state.budgets.isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Center(
                                      child: Text(
                                        'No budgets set for this month',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withValues(alpha: 0.6)),
                                      ),
                                    ),
                                  )
                                else
                                  ...state.budgets.map((b) => BudgetProgressRow(
                                        budget: b,
                                        spent: state.summary
                                                .spendByCategory[b.category] ??
                                            0,
                                      )),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 48), // Bottom padding
                      ],
                    ),
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
