import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/import_bloc.dart';
import '../bloc/import_event.dart';
import '../bloc/import_state.dart';
import '../widgets/sms_batch_card.dart';

class SmsImportPage extends StatelessWidget {
  const SmsImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Import SMS Transactions',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0F3460),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/import-history'),
          )
        ],
      ),
      body: BlocConsumer<ImportBloc, ImportState>(
        listener: (context, state) {
          if (state is ImportCompleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Imported ${state.count} transactions!'),
                  backgroundColor: const Color(0xFF0CAF60)),
            );
            Navigator.pop(context);
          }
          if (state is ImportFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Error: ${state.error}'),
                  backgroundColor: Colors.redAccent),
            );
          }
        },
        builder: (context, state) {
          if (state is ImportInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sms_outlined,
                      size: 64, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  const Text('Scan your inbox for bank SMS',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ImportBloc>().add(ScanSmsRequested()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F3460),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                    ),
                    child: const Text('Start Scan',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }
          if (state is ImportLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SmsScanSuccess) {
            if (state.pending.isEmpty) {
              return const Center(
                  child: Text('No new bank SMS found in last 30 days.'));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.pending.length,
                    itemBuilder: (context, index) {
                      final item = state.pending[index];
                      return SmsBatchCard(
                        transaction: item.transaction,
                        isSelected: item.isSelected,
                        onToggle: () => context
                            .read<ImportBloc>()
                            .add(ToggleSmsSelection(item.transaction.smsId)),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4)
                      ]),
                  child: Row(
                    children: [
                      Text(
                          '${state.pending.where((t) => t.isSelected).length} selected',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<ImportBloc>().add(ImportSelectedSms()),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0CAF60)),
                        child: const Text('Import Selected',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
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
}
