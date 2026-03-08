import 'package:flutter/material.dart';
import '../../../services/sms_parser_service.dart';
import 'import_source_badge.dart';

class SmsBatchCard extends StatelessWidget {
  final ParsedSmsTransaction transaction;
  final bool isSelected;
  final VoidCallback onToggle;

  const SmsBatchCard({
    super.key,
    required this.transaction,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: CheckboxListTile(
        value: isSelected,
        onChanged: (_) => onToggle(),
        title: Text(transaction.merchant,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Rs ${transaction.amount.toStringAsFixed(2)} • ${transaction.category}'),
            const SizedBox(height: 4),
            ImportSourceBadge(sender: transaction.sender),
          ],
        ),
        activeColor: const Color(0xFF0CAF60),
      ),
    );
  }
}
