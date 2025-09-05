import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../shared/models/semester.dart';

class CgpaAnalyticsPage extends StatefulWidget {
  final List<String> semesterKeys;
  final double cumulativeCgpa;

  const CgpaAnalyticsPage({
    super.key,
    required this.semesterKeys,
    required this.cumulativeCgpa,
  });

  @override
  State<CgpaAnalyticsPage> createState() => _CgpaAnalyticsPageState();
}

class _CgpaAnalyticsPageState extends State<CgpaAnalyticsPage> {
  List<Semester> semesters = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSemesterData();
  }

  Future<void> _loadSemesterData() async {
    List<Semester> loadedSemesters = [];

    for (String key in widget.semesterKeys) {
      final semester = await Semester.fromSharedPref(key);
      if (semester != null && semester.subjects.isNotEmpty) {
        loadedSemesters.add(semester);
      }
    }

    setState(() {
      semesters = loadedSemesters;
      isLoading = false;
    });
  }

  List<FlSpot> _generateSgpaSpots() {
    return semesters.asMap().entries.map((entry) {
      int index = entry.key;
      double sgpa = entry.value.calculateSGPA();
      return FlSpot(index.toDouble(), sgpa);
    }).toList();
  }

  List<BarChartGroupData> _generateCreditBars() {
    return semesters.asMap().entries.map((entry) {
      int index = entry.key;
      int credits = entry.value.calculateTotalCreditHours();
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: credits.toDouble(),
            color: const Color(0xFF6C5CE7),
            width: 20,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
  }

  double _getHighestSgpa() {
    if (semesters.isEmpty) return 0.0;
    return semesters
        .map((s) => s.calculateSGPA())
        .reduce((a, b) => a > b ? a : b);
  }

  double _getLowestSgpa() {
    if (semesters.isEmpty) return 0.0;
    return semesters
        .map((s) => s.calculateSGPA())
        .reduce((a, b) => a < b ? a : b);
  }

  int _getTotalCredits() {
    return semesters.fold<int>(
      0,
      (sum, semester) => sum + semester.calculateTotalCreditHours(),
    );
  }

  int _getTotalSubjects() {
    return semesters.fold<int>(
      0,
      (sum, semester) => sum + semester.calculateTotalSubjects(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'CGPA Analytics',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48), // Balance the back button
                  ],
                ),
              ),

              // Content
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : semesters.isEmpty
                      ? _buildEmptyState()
                      : _buildAnalyticsContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.analytics_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No Data Available',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Text(
            'Add some semesters to see analytics',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Overview
          _buildStatsOverview(),

          const SizedBox(height: 32),

          // SGPA Trend Chart
          _buildSgpaTrendChart(),

          const SizedBox(height: 32),

          // Credits Distribution Chart
          _buildCreditsChart(),

          const SizedBox(height: 32),

          // Semester Details
          _buildSemesterDetails(),
        ],
      ),
    );
  }

  Widget _buildStatsOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildStatCard(
              'Cumulative CGPA',
              widget.cumulativeCgpa.toStringAsFixed(2),
              Icons.trending_up,
              const Color(0xFF6C5CE7),
            ),
            const SizedBox(width: 12),
            _buildStatCard(
              'Total Semesters',
              semesters.length.toString(),
              Icons.school,
              const Color(0xFF00B894),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildStatCard(
              'Highest SGPA',
              _getHighestSgpa().toStringAsFixed(2),
              Icons.star,
              const Color(0xFFFDCB6E),
            ),
            const SizedBox(width: 12),
            _buildStatCard(
              'Lowest SGPA',
              _getLowestSgpa().toStringAsFixed(2),
              Icons.trending_down,
              const Color(0xFFE17055),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildStatCard(
              'Total Credits',
              _getTotalCredits().toString(),
              Icons.credit_score,
              const Color(0xFF74B9FF),
            ),
            const SizedBox(width: 12),
            _buildStatCard(
              'Total Subjects',
              _getTotalSubjects().toString(),
              Icons.subject,
              const Color(0xFFE84393),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSgpaTrendChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SGPA Trend',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          height: 250,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: _generateSgpaSpots(),
                  isCurved: true,
                  color: const Color(0xFF6C5CE7),
                  barWidth: 3,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    color: const Color(0xFF6C5CE7).withOpacity(0.1),
                  ),
                ),
              ],
              minY: 0,
              maxY: 4.0,
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 0.5,
                    getTitlesWidget: (value, _) => Text(
                      value.toStringAsFixed(1),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      int index = value.toInt();
                      if (index >= 0 && index < semesters.length) {
                        return Text(
                          'S${index + 1}',
                          style: const TextStyle(fontSize: 10),
                        );
                      }
                      return const Text('');
                    },
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(
                show: true,
                horizontalInterval: 0.5,
                getDrawingHorizontalLine: (value) {
                  return FlLine(color: Colors.grey[300], strokeWidth: 1);
                },
              ),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreditsChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Credits Distribution',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: BarChart(
            BarChartData(
              barGroups: _generateCreditBars(),
              alignment: BarChartAlignment.spaceAround,
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) => Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      int index = value.toInt();
                      if (index >= 0 && index < semesters.length) {
                        return Text(
                          'S${index + 1}',
                          style: const TextStyle(fontSize: 10),
                        );
                      }
                      return const Text('');
                    },
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSemesterDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Semester Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...semesters.asMap().entries.map((entry) {
          int index = entry.key;
          Semester semester = entry.value;
          double sgpa = semester.calculateSGPA();
          int credits = semester.calculateTotalCreditHours();
          int subjects = semester.calculateTotalSubjects();

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          semester.semesterName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'SGPA: ${sgpa.toStringAsFixed(2)} • Credits: $credits • Subjects: $subjects',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
