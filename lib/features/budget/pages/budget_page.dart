import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/budget_bloc.dart';
import '../bloc/budget_event.dart';
import '../bloc/budget_state.dart';
import '../widgets/set_budget_sheet.dart';
import 'package:intl/intl.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgeting',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<BudgetBloc, BudgetState>(
        builder: (context, state) {
          if (state is BudgetLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BudgetError) {
            return Center(child: Text(state.message));
          }

          if (state is BudgetData) {
            return Column(
              children: [
                // Month Picker
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () {
                          final prev = DateTime(state.currentMonth.year,
                              state.currentMonth.month - 1);
                          context
                              .read<BudgetBloc>()
                              .add(BudgetMonthChanged(prev));
                        },
                      ),
                      Text(
                        DateFormat('MMMM yyyy').format(state.currentMonth),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () {
                          final next = DateTime(state.currentMonth.year,
                              state.currentMonth.month + 1);
                          context
                              .read<BudgetBloc>()
                              .add(BudgetMonthChanged(next));
                        },
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: state.budgets.isEmpty
                      ? const Center(
                          child: Text('No budgets set for this month'))
                      : ListView.separated(
                          itemCount: state.budgets.length,
                          padding: const EdgeInsets.all(16),
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final budget = state.budgets[index];
                            return ListTile(
                              tileColor: Colors.black.withValues(alpha: 0.05),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              title: Text(budget.category,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              trailing: Text(
                                  '₹${budget.amount.toStringAsFixed(0)}',
                                  style: const TextStyle(fontSize: 16)),
                              onLongPress: () {
                                context
                                    .read<BudgetBloc>()
                                    .add(BudgetDeleted(budget.uuid));
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            builder: (_) => SetBudgetSheet(
              onSet: (category, amount) {
                context
                    .read<BudgetBloc>()
                    .add(BudgetSetRequested(category, amount));
              },
            ),
          );
        },
        backgroundColor: const Color(0xFF0F3460),
        icon: const Icon(Icons.add_chart),
        label: const Text('Set New Budget'),
      ),
    );
  }
}

