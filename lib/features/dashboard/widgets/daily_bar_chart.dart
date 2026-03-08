import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DailyBarChart extends StatelessWidget {
  final Map<String, double> dailyData;

  const DailyBarChart({super.key, required this.dailyData});

  @override
  Widget build(BuildContext context) {
    if (dailyData.isEmpty) return const SizedBox.shrink();

    final List<BarChartGroupData> barGroups = [];
    final days = dailyData.keys.toList()..sort();

    for (int i = 0; i < days.length; i++) {
      final day = days[i];
      final val = dailyData[day]!;
      barGroups.add(
        BarChartGroupData(
          x: int.parse(day),
          barRods: [
            BarChartRodData(
              toY: val,
              color: const Color(0xFF0F3460),
              width: 12,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
    }

    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daily Spending',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 160,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: dailyData.values.reduce((a, b) => a > b ? a : b) * 1.2,
                  barGroups: barGroups,
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (val, meta) {
                          if (val % 5 == 0 || val == 1) {
                            return Text(val.toInt().toString(),
                                style: const TextStyle(fontSize: 10));
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
