import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../bloc/export_bloc.dart';
import '../bloc/export_event.dart';
import '../bloc/export_state.dart';

class ExportOptionsSheet extends StatefulWidget {
  const ExportOptionsSheet({super.key});

  @override
  State<ExportOptionsSheet> createState() => _ExportOptionsSheetState();
}

class _ExportOptionsSheetState extends State<ExportOptionsSheet> {
  DateTime _selectedMonth = DateTime.now();

  void _nextMonth() => setState(() {
        _selectedMonth =
            DateTime(_selectedMonth.year, _selectedMonth.month + 1);
      });

  void _prevMonth() => setState(() {
        _selectedMonth =
            DateTime(_selectedMonth.year, _selectedMonth.month - 1);
      });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExportBloc, ExportState>(
      listener: (context, state) {
        if (state is ExportReady) {
          Share.shareXFiles(
            [XFile(state.file.path)],
            subject:
                'FinTrack Pro — ${state.format.name.toUpperCase()} Statement',
          );
          Navigator.pop(context);
        } else if (state is ExportError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Export failed: ${state.message}')),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Export Expenses',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: _prevMonth,
                    icon: const Icon(Icons.chevron_left)),
                Text(
                  DateFormat('MMMM yyyy').format(_selectedMonth),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: _nextMonth,
                    icon: const Icon(Icons.chevron_right)),
              ],
            ),
            const SizedBox(height: 20),
            _ExportFormatCard(
              title: 'PDF Statement',
              subtitle: 'Formatted report with category summary',
              icon: Icons.picture_as_pdf,
              color: Colors.red.shade700,
              onTap: () => _triggerExport(context, ExportFormat.pdf),
            ),
            const SizedBox(height: 12),
            _ExportFormatCard(
              title: 'CSV Spreadsheet',
              subtitle: 'Raw data for Excel / Google Sheets',
              icon: Icons.table_chart,
              color: Colors.green.shade700,
              onTap: () => _triggerExport(context, ExportFormat.csv),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _triggerExport(BuildContext context, ExportFormat format) {
    final monthStr = DateFormat('yyyy-MM').format(_selectedMonth);
    context
        .read<ExportBloc>()
        .add(ExportRequested(month: monthStr, format: format));
  }
}

class _ExportFormatCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ExportFormatCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExportBloc, ExportState>(
      builder: (context, state) {
        final isGenerating = state is ExportGenerating;

        return InkWell(
          onTap: isGenerating ? null : onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(subtitle,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600)),
                    ],
                  ),
                ),
                if (isGenerating)
                  const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                else
                  const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
