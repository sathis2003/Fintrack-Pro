import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryDonutChart extends StatelessWidget {
  final Map<String, double> categoryData;

  const CategoryDonutChart({super.key, required this.categoryData});

  @override
  Widget build(BuildContext context) {
    if (categoryData.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text('No data for this month')),
      );
    }

    final List<Color> colors = [
      const Color(0xFF0F3460),
      const Color(0xFFE94560),
      const Color(0xFF0CAF60),
      const Color(0xFFFBBC05),
      const Color(0xFF4285F4),
      const Color(0xFF9B51E0),
      const Color(0xFFF2994A),
      Colors.grey,
    ];

    int colorIndex = 0;
    final sections = categoryData.entries.map((e) {
      final color = colors[colorIndex % colors.length];
      colorIndex++;
      return PieChartSectionData(
        value: e.value,
        title: '',
        color: color,
        radius: 40,
        showTitle: false,
      );
    }).toList();

    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sections: sections,
              sectionsSpace: 2,
              centerSpaceRadius: 60,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Top Category',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                categoryData.keys.first,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F3460),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
