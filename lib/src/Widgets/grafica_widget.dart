import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LinealCharts extends StatelessWidget {
  const LinealCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 350.0,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: [
                  const FlSpot(0, 1),
                  const FlSpot(1, 3),
                  const FlSpot(2, 7),
                  const FlSpot(4, 6),
                  const FlSpot(7, 12),
                ],
                isCurved: true,
              ),
              LineChartBarData(spots: [
                const FlSpot(0, 4),
                const FlSpot(1, 8),
                const FlSpot(2, 2),
                const FlSpot(4, 7),
                const FlSpot(7, 10),
              ], isCurved: true),
            ],
          ),
        ),
      ),
    );
  }
}
