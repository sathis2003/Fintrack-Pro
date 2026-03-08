import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../bloc/insights_bloc.dart';
import '../bloc/insights_event.dart';
import '../bloc/insights_state.dart';
import '../widgets/health_report_card.dart';
import 'package:intl/intl.dart';

class InsightsPage extends StatefulWidget {
  const InsightsPage({super.key});

  @override
  State<InsightsPage> createState() => _InsightsPageState();
}

class _InsightsPageState extends State<InsightsPage> {
  final String _currentMonth = DateFormat('yyyy-MM').format(DateTime.now());
  ISentrySpan? _transaction;

  @override
  void initState() {
    super.initState();
    _transaction = Sentry.startTransaction('insights.load', 'ui.load');
    context.read<InsightsBloc>().add(InsightsLoaded(_currentMonth));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Insights',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: BlocListener<InsightsBloc, InsightsState>(
        listener: (context, state) {
          if (state is InsightsData) {
            _transaction?.finish(status: const SpanStatus.ok());
            _transaction = null;
          }
        },
        child: BlocBuilder<InsightsBloc, InsightsState>(
          buildWhen: (prev, curr) => prev != curr,
          builder: (context, state) {
            if (state is InsightsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is InsightsError) {
              return Center(child: Text(state.message));
            }

            if (state is InsightsEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'No report generated for this month.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<InsightsBloc>().add(
                            InsightsGenerateRequested(
                                _currentMonth, 50000)); // TODO: Real income
                      },
                      icon: const Icon(Icons.rocket_launch),
                      label: const Text('Generate AI Report'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F3460),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is InsightsData) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    HealthReportCard(insight: state.insight),
                    const SizedBox(height: 24),

                    // Score Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatItem(
                            label: 'Health Score',
                            value: '${state.insight.riskScore.toInt()}/100',
                            color: _getScoreColor(state.insight.riskScore),
                          ),
                          _StatItem(
                            label: 'Exhaustion Date',
                            value: state.insight.exhaustionDate != null
                                ? DateFormat('MMM dd')
                                    .format(state.insight.exhaustionDate!)
                                : 'End of Month',
                            color: Colors.blueGrey,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
                    TextButton.icon(
                      onPressed: () {
                        context.read<InsightsBloc>().add(
                            InsightsGenerateRequested(_currentMonth, 50000));
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Regenerate Analysis'),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 80) return Colors.green;
    if (score >= 50) return Colors.orange;
    return Colors.red;
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatItem(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}

