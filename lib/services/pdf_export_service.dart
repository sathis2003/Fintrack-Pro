import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../domain/entities/expense.dart';

class PdfExportService {
  static Future<File> generateMonthlyStatement({
    required List<Expense> expenses,
    required String month, // "April 2025"
    required String userName,
    required double monthlyIncome,
  }) async {
    final pdf = pw.Document();

    final total = expenses.fold(0.0, (s, e) => s + e.amount);
    final byCategory = _groupByCategory(expenses);
    final sortedExpenses = [...expenses]
      ..sort((a, b) => b.date.compareTo(a.date));

    try {
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(40),
          header: (context) => _buildHeader(userName, month),
          footer: (context) => _buildFooter(context),
          build: (context) => [
            _buildSummarySection(total, monthlyIncome, expenses.length),
            pw.SizedBox(height: 24),
            _buildCategoryBreakdown(byCategory, total),
            pw.SizedBox(height: 24),
            _buildExpenseTable(sortedExpenses),
          ],
        ),
      );

      final dir = await getTemporaryDirectory();
      final file =
          File('${dir.path}/fintrack_${month.replaceAll(' ', '_')}.pdf');
      await file.writeAsBytes(await pdf.save());
      return file;
    } catch (e, stackTrace) {
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
        hint: Hint.withMap({
          'context': 'pdf_gen_error',
          'month': month,
          'expense_count': expenses.length.toString(),
        }),
      );
      rethrow;
    }
  }

  static pw.Widget _buildHeader(String name, String month) => pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text('FinTrack Pro',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromHex('#0F3460'),
                )),
            pw.Text('Monthly Expense Statement',
                style: pw.TextStyle(fontSize: 11, color: PdfColors.grey600)),
          ]),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
            pw.Text(month,
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.Text(name,
                style: pw.TextStyle(fontSize: 11, color: PdfColors.grey600)),
          ]),
        ],
      );

  static pw.Widget _buildSummarySection(
          double total, double income, int count) =>
      pw.Container(
        padding: const pw.EdgeInsets.all(16),
        decoration: pw.BoxDecoration(
          color: PdfColor.fromHex('#F0F4FF'),
          borderRadius: pw.BorderRadius.circular(8),
        ),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
          children: [
            _summaryItem('Total Spent', '₹${_fmt(total)}'),
            _summaryItem('Monthly Income', '₹${_fmt(income)}'),
            _summaryItem('Saved', '₹${_fmt(income - total)}'),
            _summaryItem('Expenses', '$count'),
          ],
        ),
      );

  static pw.Widget _buildCategoryBreakdown(
      Map<String, double> byCategory, double total) {
    final rows = byCategory.entries.where((e) => e.value > 0).toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Category Breakdown',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
          columnWidths: {
            0: const pw.FlexColumnWidth(3),
            1: const pw.FlexColumnWidth(2),
            2: const pw.FlexColumnWidth(2),
          },
          children: [
            _tableHeaderRow(['Category', 'Amount', '% of Total']),
            ...rows.map((e) => _tableDataRow([
                  e.key,
                  '₹${_fmt(e.value)}',
                  '${(total > 0 ? (e.value / total * 100) : 0).toStringAsFixed(1)}%',
                ])),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildExpenseTable(List<Expense> expenses) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('All Transactions',
              style:
                  pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 8),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(3),
              2: const pw.FlexColumnWidth(2),
              3: const pw.FlexColumnWidth(2),
            },
            children: [
              _tableHeaderRow(['Date', 'Description', 'Category', 'Amount']),
              ...expenses.map((e) => _tableDataRow([
                    DateFormat('d MMM').format(e.date),
                    e.description,
                    e.category,
                    '₹${_fmt(e.amount)}',
                  ])),
            ],
          ),
        ],
      );

  static pw.TableRow _tableHeaderRow(List<String> headers) => pw.TableRow(
        decoration: pw.BoxDecoration(color: PdfColor.fromHex('#0F3460')),
        children: headers
            .map((h) => pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(h,
                      style: pw.TextStyle(
                          color: PdfColors.white,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 10)),
                ))
            .toList(),
      );

  static pw.TableRow _tableDataRow(List<String> cells) => pw.TableRow(
      children: cells
          .map((c) => pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: pw.Text(c, style: const pw.TextStyle(fontSize: 9)),
              ))
          .toList());

  static pw.Widget _buildFooter(pw.Context context) =>
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Text('Generated by FinTrack Pro',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey)),
        pw.Text('Page ${context.pageNumber} of ${context.pagesCount}',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey)),
      ]);

  static pw.Widget _summaryItem(String label, String value) =>
      pw.Column(children: [
        pw.Text(value,
            style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromHex('#0F3460'))),
        pw.Text(label,
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
      ]);

  static String _fmt(double v) => v
      .toStringAsFixed(0)
      .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');

  static Map<String, double> _groupByCategory(List<Expense> expenses) {
    final map = <String, double>{};
    for (final e in expenses) {
      map[e.category] = (map[e.category] ?? 0) + e.amount;
    }
    return map;
  }
}
