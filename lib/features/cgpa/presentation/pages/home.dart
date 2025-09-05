import 'package:flutter/material.dart';
import 'package:nu_result/features/cgpa/presentation/pages/chart_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/gplay_contants.dart';
import '../../../../shared/models/semester.dart';
import 'cgpa_calculator_page.dart';

const String kYearResultsKey = 'yearResults';

class GHomePage extends StatefulWidget {
  const GHomePage({super.key});

  @override
  GHomePageState createState() => GHomePageState();
}

class GHomePageState extends State<GHomePage> {
  List<String> yearResults = [];
  double averageCgpa = 0.0;

  @override
  void initState() {
    super.initState();
    _loadYearResults();
  }

  Future<void> _loadYearResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      yearResults = prefs.getStringList(kYearResultsKey) ?? [];
    });
    _calculateAverageCgpa();
  }

  void _addYearResult(String year) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    yearResults.add(year);
    await prefs.setStringList(kYearResultsKey, yearResults);
    setState(() {});
  }

  void _saveYearResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(kYearResultsKey, yearResults);
  }

  void _navigateToCgpaCalculator(String year) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CgpaCalculatorPage(
          semesterName: year,
        ),
      ),
    ).then((_) => _loadYearResults());
  }

  Future<void> _calculateAverageCgpa() async {
    double totalGradePoints = 0.0;
    int totalCreditHours = 0;

    for (String year in yearResults) {
      final semester = await Semester.fromSharedPref(year);
      if (semester != null) {
        double semesterGPA = semester.calculateSGPA();
        int semesterCredits = semester.calculateTotalCreditHours();

        totalGradePoints += semesterGPA * semesterCredits;
        totalCreditHours += semesterCredits;
      }
    }

    setState(() {
      averageCgpa =
          totalCreditHours == 0 ? 0.0 : totalGradePoints / totalCreditHours;
    });
  }

  Future<Map<String, dynamic>> _fetchYearData(String year) async {
    final Semester? semester = await Semester.fromSharedPref(year);
    if (semester == null) {
      return {
        'yearCgpa': 0.0,
        'totalSubjects': 0,
        'totalCredits': 0,
      };
    }

    double yearCgpa = semester.calculateSGPA();
    int totalSubjects = semester.calculateTotalSubjects();
    int totalCredits = semester.calculateTotalCreditHours();

    return {
      'yearCgpa': yearCgpa,
      'totalSubjects': totalSubjects,
      'totalCredits': totalCredits,
    };
  }

  void _showDevInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Developer Info'),
          content: Text('This app is developed by Zaman Sheikh'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _showDevInfoDialog(context);
          },
          color: Colors.white,
          icon: Icon(Icons.info),
        ),
        title: Text(GplayContants.appTitle),
        backgroundColor: Colors.teal[800],
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.bar_chart),
            onPressed: () async {
              List<Semester> semesters = [];
              for (String year in yearResults) {
                final semester = await Semester.fromSharedPref(year);
                if (semester != null) semesters.add(semester);
              }
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GChartPage(
                      semesters: semesters,
                      averageCgpa: averageCgpa,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Average CGPA: ${averageCgpa.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: yearResults.length,
                itemBuilder: (context, index) {
                  final year = yearResults[index];
                  return FutureBuilder<Map<String, dynamic>>(
                    future: _fetchYearData(year),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final yearData = snapshot.data ?? {};
                      double yearCgpa = yearData['yearCgpa'] ?? 0.0;
                      int totalSubjects = yearData['totalSubjects'] ?? 0;
                      int totalCredits = yearData['totalCredits'] ?? 0;

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        color: Colors.white,
                        child: ListTile(
                          onTap: () => _navigateToCgpaCalculator(year),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          title: Text(
                            year.replaceAll('_', ' ').toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.teal[800],
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CGPA: ${yearCgpa.toStringAsFixed(2)}',
                                  style: TextStyle(color: Colors.blueGrey[700]),
                                ),
                                Text(
                                  'Total Subjects: $totalSubjects',
                                  style: TextStyle(color: Colors.indigo[600]),
                                ),
                                Text(
                                  'Total Credits: $totalCredits',
                                  style: TextStyle(color: Colors.orange[600]),
                                ),
                              ],
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon:
                                    Icon(Icons.delete, color: Colors.red[300]),
                                onPressed: () {
                                  setState(() {
                                    yearResults.removeAt(index);
                                    _saveYearResults();
                                  });
                                },
                              ),
                              const Icon(Icons.arrow_forward_ios,
                                  color: Colors.teal),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            _buildAddResultCard()
          ],
        ),
      ),
    );
  }

  Widget _buildAddResultCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      color: Colors.white,
      child: ListTile(
        onTap: () {
          String nextYearKey = 'year_${yearResults.length + 1}';
          _addYearResult(nextYearKey);
          _navigateToCgpaCalculator(nextYearKey);
        },
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        title: Text(
          'Add Your Result',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.teal[800],
          ),
        ),
        leading: Icon(Icons.add_circle, color: Colors.orange[600], size: 32),
        subtitle: const Text(
          'Tap to add your new year result',
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
    );
  }
}
