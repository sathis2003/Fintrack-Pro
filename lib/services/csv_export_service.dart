import 'dart:io';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../domain/entities/expense.dart';

class CsvExportService {
  static Future<File> generateCsv({
    required List<Expense> expenses,
    required String month,
  }) async {
    final rows = <List<String>>[
      // Header row
      [
        'Date',
        'Description',
        'Category',
        'Amount (INR)',
        'Recurring',
        'Source'
      ],
      // Data rows
      ...expenses.map((e) => [
            DateFormat('yyyy-MM-dd').format(e.date),
            e.description,
            e.category,
            e.amount.toStringAsFixed(2),
            e.isRecurring ? 'Yes' : 'No',
            e.source, // "chat" | "manual"
          ]),
    ];

    final csvString = const ListToCsvConverter().convert(rows);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/fintrack_${month.replaceAll(' ', '_')}.csv');
    await file.writeAsString(csvString);
    return file;
  }
}
