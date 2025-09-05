import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../shared/models/semester.dart';

class GChartPage extends StatelessWidget {
  final List<Semester> semesters;
  final double averageCgpa;

  const GChartPage({
    super.key,
    required this.semesters,
    required this.averageCgpa,
  });

  List<FlSpot> _generateCgpaSpots() {
    return semesters.asMap().entries.map((entry) {
      int index = entry.key;
      double sgpa = entry.value.calculateSGPA();
      return FlSpot(index.toDouble(), sgpa);
    }).toList();
  }

  String _semesterName(int index) =>
      semesters[index].semesterName.replaceAll('_', ' ').toUpperCase();
  List<BarChartGroupData> _generateCgpaBars() {
    return semesters.asMap().entries.map((entry) {
      int index = entry.key;
      double sgpa = entry.value.calculateSGPA();
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: sgpa,
            color: Colors.teal,
            width: 20,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Semester CGPA Chart"),
        backgroundColor: Colors.teal[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "CGPA Overview",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            // Line Chart for CGPA trends
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _generateCgpaSpots(),
                      isCurved: true,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      color: Colors.teal,
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.teal.withValues(alpha: 0.3),
                      ),
                    ),
                  ],
                  minY: 0,
                  maxY: 4.0,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: .5,
                        getTitlesWidget: (value, _) =>
                            Text(value.toStringAsFixed(1)),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          int index = value.toInt();
                          if (index >= 0 && index < semesters.length) {
                            return Text(
                              _semesterName(index),
                              style: TextStyle(fontSize: 10),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (LineBarSpot spot) =>
                          Colors.blueGrey[700]!,
                    ),
                  ),
                  gridData: FlGridData(show: true, horizontalInterval: 0.5),
                  borderData: FlBorderData(show: true),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Bar Chart for CGPA per semester
            Expanded(
              child: BarChart(
                BarChartData(
                  barGroups: _generateCgpaBars(),
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 4.0,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 0.5,
                        getTitlesWidget: (value, _) =>
                            Text(value.toStringAsFixed(1)),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          int index = value.toInt();
                          if (index >= 0 && index < semesters.length) {
                            return Text(
                              _semesterName(index),
                              style: TextStyle(fontSize: 10),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(show: true, horizontalInterval: 0.5),
                  borderData: FlBorderData(show: true),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (group) => Colors.blueGrey[700]!,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          'Semester: ${semesters[groupIndex].semesterName}\nSGPA: ${rod.toY.toStringAsFixed(2)}',
                          TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Average CGPA display
            Text(
              "Average CGPA: ${averageCgpa.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
