import 'package:equatable/equatable.dart';

class MonthlySummary extends Equatable {
  final double totalSpend;
  final Map<String, double> spendByCategory; // category → amount
  final Map<String, double> dailySpend; // "DD" → amount
  final double previousMonthTotal;
  final double changePercent; // positive = more spent than last month

  const MonthlySummary({
    required this.totalSpend,
    required this.spendByCategory,
    required this.dailySpend,
    required this.previousMonthTotal,
    required this.changePercent,
  });

  @override
  List<Object?> get props => [
        totalSpend,
        spendByCategory,
        dailySpend,
        previousMonthTotal,
        changePercent,
      ];
}
