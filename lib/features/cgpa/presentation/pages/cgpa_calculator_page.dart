import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../shared/models/semester.dart';


class CgpaCalculatorPage extends StatefulWidget {
  final String semesterName;
  const CgpaCalculatorPage({required this.semesterName, super.key});

  @override
  CgpaCalculatorPageState createState() => CgpaCalculatorPageState();
}

class CgpaCalculatorPageState extends State<CgpaCalculatorPage> {
  List<Subject> subjects = [];
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> creditControllers = [];
  TextEditingController gpaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSubjectsFromPrefs();
  }

  String get _semesterName =>
      widget.semesterName.replaceAll('_', ' ').toUpperCase();

  // Load saved subjects from shared preferences
  void _loadSubjectsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedSemesterJson = prefs.getString(widget.semesterName);
    if (savedSemesterJson != null) {
      setState(() {
        final savedSemester = Semester.fromJson(jsonDecode(savedSemesterJson));
        subjects = savedSemester.subjects;
        _initializeControllers();
        gpaController.text = _calculateGPA().toStringAsFixed(2);
      });
    } else {
      _initializeDefaultRows();
    }
  }

  // Save subjects to shared preferences
  void _saveSubjectsToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final semester =
        Semester(semesterName: widget.semesterName, subjects: subjects);
    prefs.setString(widget.semesterName, jsonEncode(semester.toJson()));
  }

  // Initialize controllers for name and credit fields
  void _initializeControllers() {
    nameControllers = subjects
        .map((subject) => TextEditingController(text: subject.subjectName))
        .toList();
    creditControllers = subjects
        .map((subject) =>
            TextEditingController(text: subject.creditHours.toString()))
        .toList();
  }

  // Initialize the default two rows
  void _initializeDefaultRows() {
    setState(() {
      subjects = [
        Subject(subjectName: 'Sub1', creditHours: 3, letterGrade: 'A+'),
        Subject(subjectName: 'Sub2', creditHours: 3, letterGrade: 'A+'),
      ];
      _initializeControllers();
      _saveSubjectsToPrefs();
      gpaController.text = _calculateGPA().toStringAsFixed(2);
    });
  }

  bool isValidGrade(String grade) {
    return ['A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'D', 'F']
        .contains(grade);
  }

  // Add a new row for subjects
  void _addNewSubjectRow() {
    setState(() {
      int nextIndex = subjects.length + 1;
      subjects.add(Subject(
          subjectName: 'Sub$nextIndex', creditHours: 3, letterGrade: 'A+'));
      nameControllers.add(TextEditingController(text: 'Sub$nextIndex'));
      creditControllers.add(TextEditingController(text: '3'));
      _saveSubjectsToPrefs();
      gpaController.text = _calculateGPA().toStringAsFixed(2);
    });
  }

  // Clear all data and reset to default
  void _clearAll() {
    setState(() {
      _initializeDefaultRows();
      gpaController.clear();
      gpaController.text = _calculateGPA().toStringAsFixed(2);
    });
    _saveSubjectsToPrefs();
  }

  // Calculate GPA based on input values
  double _calculateGPA() {
    final semester =
        Semester(semesterName: widget.semesterName, subjects: subjects);
    _saveSubjectsToPrefs();
    return semester.calculateSGPA();
  }

  // Update subject details in real-time and save to shared preferences
  void _updateSubject(int index, String field, String value) {
    setState(() {
      final subject = subjects[index];
      switch (field) {
        case 'name':
          subjects[index] = subject.copyWith(subjectName: value);
          break;
        case 'credit':
          int credit = int.tryParse(value) ?? 0;
          subjects[index] = subject.copyWith(creditHours: credit);
          break;
        case 'grade':
          if (isValidGrade(value)) {
            subjects[index] = subject.copyWith(letterGrade: value);
          }
          break;
      }
      _saveSubjectsToPrefs();
      gpaController.text = _calculateGPA().toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal[800],
        title: Text('$_semesterName - SGPA'),
        actions: [
          IconButton(
            icon: const Icon(color: Colors.white, Icons.refresh),
            onPressed: _clearAll,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: nameControllers[index],
                            decoration: InputDecoration(
                              labelText: 'Subject ${index + 1}',
                              border: const OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              _updateSubject(index, 'name', value);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: creditControllers[index],
                            decoration: const InputDecoration(
                              labelText: 'Credit',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            onChanged: (value) {
                              _updateSubject(index, 'credit', value);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                            initialValue: subjects[index].letterGrade,
                            decoration: const InputDecoration(
                              labelText: 'Grade',
                              border: OutlineInputBorder(),
                            ),
                            items: const [
                              DropdownMenuItem(value: 'A+', child: Text('A+')),
                              DropdownMenuItem(value: 'A', child: Text('A')),
                              DropdownMenuItem(value: 'A-', child: Text('A-')),
                              DropdownMenuItem(value: 'B+', child: Text('B+')),
                              DropdownMenuItem(value: 'B', child: Text('B')),
                              DropdownMenuItem(value: 'B-', child: Text('B-')),
                              DropdownMenuItem(value: 'C+', child: Text('C+')),
                              DropdownMenuItem(value: 'C', child: Text('C')),
                              DropdownMenuItem(value: 'D', child: Text('D')),
                              DropdownMenuItem(value: 'F', child: Text('F')),
                            ],
                            onChanged: (value) {
                              _updateSubject(index, 'grade', value ?? 'A+');
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addNewSubjectRow,
              child: const Text('Add Subject'),
            ),
            const SizedBox(width: 16),
            const SizedBox(height: 16),
            TextFormField(
              controller: gpaController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Your CGPA',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
