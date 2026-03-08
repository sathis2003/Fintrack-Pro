import 'package:flutter/material.dart';
import '../../../data/local/database/app_database.dart';
import 'import_source_badge.dart';
import 'package:intl/intl.dart';

class ImportHistoryTile extends StatelessWidget {
  final SmsImportLogTableData log;
  const ImportHistoryTile({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF0F3460),
          child: Icon(Icons.sms, color: Colors.white, size: 20),
        ),
        title: Text(log.merchant,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rs ${log.amount.toStringAsFixed(2)} • ${log.category}'),
            Text(DateFormat('dd MMM yyyy, hh:mm a').format(log.smsDate),
                style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            ImportSourceBadge(sender: log.sender),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
