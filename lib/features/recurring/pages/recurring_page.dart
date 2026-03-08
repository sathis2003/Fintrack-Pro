import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/recurring_bloc.dart';
import '../bloc/recurring_bloc_parts.dart';
import '../../../core/constants/colors.dart';
import '../widgets/add_recurring_sheet.dart';
import '../../../core/widgets/empty_state.dart';

class RecurringPage extends StatefulWidget {
  const RecurringPage({super.key});

  @override
  State<RecurringPage> createState() => _RecurringPageState();
}

class _RecurringPageState extends State<RecurringPage> {
  @override
  void initState() {
    super.initState();
    context.read<RecurringBloc>().add(RecurringLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recurring Expenses',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome),
            tooltip: 'Detect Patterns',
            onPressed: () {
              context.read<RecurringBloc>().add(RecurringDetectorStarted());
            },
          ),
        ],
      ),
      body: BlocBuilder<RecurringBloc, RecurringState>(
        builder: (context, state) {
          if (state.isDetecting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('AI is analyzing your patterns...',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          if (state.recurrings.isEmpty) {
            return Center(
              child: SingleChildScrollView(
                child: EmptyState(
                  lottiePath: 'assets/lottie/ai_chat_bot.json',
                  title: 'No recurring expenses',
                  subtitle:
                      'Let AI scan your history for regular payments like rent or subscriptions.',
                  action: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C2BD9), Color(0xFF00C2CB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C2BD9).withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                      ),
                      onPressed: () {
                        context
                            .read<RecurringBloc>()
                            .add(RecurringDetectorStarted());
                      },
                      icon: const Icon(Icons.auto_awesome, color: Colors.white),
                      label: const Text('Scan History',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.recurrings.length,
            itemBuilder: (context, index) {
              final r = state.recurrings[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.repeat, color: AppColors.primary),
                  ),
                  title: Text(r.description,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                          'Next: ${DateFormat('MMM dd').format(DateTime.parse(r.nextExpectedDate))}'),
                      Text('Frequency: ${r.frequency}',
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('₹${r.averageAmount.toStringAsFixed(0)}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary)),
                      const SizedBox(height: 4),
                      Text('Day ${r.dayOfMonth}',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => const AddRecurringSheet(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Manual'),
      ),
    );
  }
}
