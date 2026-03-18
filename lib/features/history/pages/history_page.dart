import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_event.dart';
import '../bloc/history_state.dart';
import '../widgets/expense_list_tile.dart';
import '../widgets/filter_bar.dart';
import '../../export/bloc/export_bloc.dart';
import '../../export/widgets/export_options_sheet.dart';
import '../../../core/di/injection.dart';
import '../../../../core/widgets/empty_state.dart';

import '../../../core/widgets/fintrack_top_bar.dart';

class HistoryPage extends StatelessWidget {
  final VoidCallback onMenuTap;
  const HistoryPage({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FinTrackTopBar(
        title: 'Expense History',
        onMenuTap: onMenuTap,
        action: IconButton(
          icon: const Icon(Icons.upload),
          onPressed: () => _showExportSheet(context),
          tooltip: 'Export Statement',
        ),
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HistoryError) {
            return Center(child: Text(state.message));
          }

          if (state is HistoryData) {
            return Column(
              children: [
                FilterBar(
                  filter: state.filter,
                  onFilterChanged: (newFilter) {
                    context
                        .read<HistoryBloc>()
                        .add(HistoryFilterChanged(newFilter));
                  },
                ),
                const Divider(),
                Expanded(
                  child: state.expenses.isEmpty
                      ? const EmptyState(
                          lottiePath: 'assets/lottie/empty_history.json',
                          title: 'No Expenses Yet',
                          subtitle:
                              'Your history will appear here once you start tracking',
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: state.expenses.length,
                          separatorBuilder: (_, __) =>
                              const Divider(height: 1, indent: 70),
                          itemBuilder: (context, index) {
                            final expense = state.expenses[index];
                            return ExpenseListTile(
                              expense: expense,
                              onDelete: () {
                                context
                                    .read<HistoryBloc>()
                                    .add(HistoryExpenseDeleted(expense.uuid));
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
    );
  }

  void _showExportSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BlocProvider(
        create: (_) => getIt<ExportBloc>(),
        child: const ExportOptionsSheet(),
      ),
    );
  }
}
