import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/import_bloc.dart';
import '../bloc/import_event.dart';
import '../bloc/import_state.dart';
import '../widgets/import_history_tile.dart';

class ImportHistoryPage extends StatefulWidget {
  const ImportHistoryPage({super.key});
  @override
  State<ImportHistoryPage> createState() => _ImportHistoryPageState();
}

class _ImportHistoryPageState extends State<ImportHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<ImportBloc>().add(LoadImportHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Import History',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0F3460),
      ),
      body: BlocBuilder<ImportBloc, ImportState>(
        builder: (context, state) {
          if (state is ImportLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ImportHistoryLoaded) {
            if (state.logs.isEmpty) {
              return const Center(child: Text('No imports yet.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.logs.length,
              itemBuilder: (context, index) {
                return ImportHistoryTile(log: state.logs[index]);
              },
            );
          }
          if (state is ImportFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
