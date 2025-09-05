import 'package:flutter/material.dart';
import '../../../../shared/models/semester.dart';

class CgpaCalculatorPage extends StatefulWidget {
  final String semesterKey;

  const CgpaCalculatorPage({super.key, required this.semesterKey});

  @override
  State<CgpaCalculatorPage> createState() => _CgpaCalculatorPageState();
}

class _CgpaCalculatorPageState extends State<CgpaCalculatorPage>
    with TickerProviderStateMixin {
  List<Subject> subjects = [];
  String semesterName = '';
  double currentSgpa = 0.0;
  bool isLoading = true;
  late AnimationController _animationController;

  final List<String> gradeOptions = [
    'A+',
    'A',
    'A-',
    'B+',
    'B',
    'B-',
    'C+',
    'C',
    'D',
    'F',
  ];
  final List<int> creditOptions = [1, 2, 3, 4, 5, 6];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _loadSemesterData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadSemesterData() async {
    setState(() => isLoading = true);

    final semester = await Semester.fromSharedPref(widget.semesterKey);
    if (semester != null) {
      setState(() {
        semesterName = semester.semesterName;
        subjects = semester.subjects.toList();
        if (subjects.isEmpty) {
          // Add default subjects if none exist
          subjects = [
            const Subject(subjectName: '', creditHours: 3, letterGrade: 'A+'),
            const Subject(subjectName: '', creditHours: 3, letterGrade: 'A+'),
          ];
        }
      });
    } else {
      setState(() {
        semesterName = 'New Semester';
        subjects = [
          const Subject(subjectName: '', creditHours: 3, letterGrade: 'A+'),
          const Subject(subjectName: '', creditHours: 3, letterGrade: 'A+'),
        ];
      });
    }

    _calculateSgpa();
    setState(() => isLoading = false);
    _animationController.forward();
  }

  void _calculateSgpa() {
    if (subjects.isEmpty) {
      setState(() => currentSgpa = 0.0);
      return;
    }

    double totalGradePoints = 0.0;
    int totalCredits = 0;

    for (final subject in subjects) {
      if (subject.subjectName.trim().isNotEmpty) {
        totalGradePoints += subject.gradePoints * subject.creditHours;
        totalCredits += subject.creditHours;
      }
    }

    setState(() {
      currentSgpa = totalCredits > 0 ? totalGradePoints / totalCredits : 0.0;
    });
  }

  Future<void> _saveSemester() async {
    // Filter out empty subjects
    final validSubjects = subjects
        .where((subject) => subject.subjectName.trim().isNotEmpty)
        .toList();

    final semester = Semester(
      semesterName: semesterName,
      subjects: validSubjects,
    );

    await semester.toSharedPref(widget.semesterKey);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semester data saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _addSubject() {
    setState(() {
      subjects.add(
        const Subject(subjectName: '', creditHours: 3, letterGrade: 'A+'),
      );
    });
    _calculateSgpa();
  }

  void _removeSubject(int index) {
    if (subjects.length > 1) {
      setState(() {
        subjects.removeAt(index);
      });
      _calculateSgpa();
      _saveSemester();
    }
  }

  void _updateSubject(
    int index, {
    String? subjectName,
    int? creditHours,
    String? letterGrade,
  }) {
    setState(() {
      subjects[index] = subjects[index].copyWith(
        subjectName: subjectName,
        creditHours: creditHours,
        letterGrade: letterGrade,
      );
    });
    _calculateSgpa();
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A+':
        return const Color(0xFF27AE60);
      case 'A':
        return const Color(0xFF2ECC71);
      case 'A-':
        return const Color(0xFF58D68D);
      case 'B+':
        return const Color(0xFF3498DB);
      case 'B':
        return const Color(0xFF5DADE2);
      case 'B-':
        return const Color(0xFF85C1E9);
      case 'C+':
        return const Color(0xFFF39C12);
      case 'C':
        return const Color(0xFFE67E22);
      case 'D':
        return const Color(0xFFE74C3C);
      case 'F':
        return const Color(0xFFC0392B);
      default:
        return Colors.grey;
    }
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
                      onPressed: () {
                        _saveSemester();
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        semesterName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _showSemesterNameDialog(),
                      icon: const Icon(Icons.edit, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // SGPA Display
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'CURRENT SGPA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentSgpa.toStringAsFixed(2),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 60,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    Column(
                      children: [
                        const Text(
                          'TOTAL CREDITS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          subjects
                              .where((s) => s.subjectName.trim().isNotEmpty)
                              .fold<int>(0, (sum, s) => sum + s.creditHours)
                              .toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Subjects List
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subjects',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            TextButton.icon(
                              onPressed: _addSubject,
                              icon: const Icon(Icons.add),
                              label: const Text('Add Subject'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      if (isLoading)
                        const Expanded(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            itemCount: subjects.length,
                            itemBuilder: (context, index) {
                              return FadeTransition(
                                opacity: _animationController,
                                child: _buildSubjectCard(index),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await _saveSemester();
          Navigator.pop(context);
        },
        backgroundColor: const Color(0xFF6C5CE7),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.save),
        label: const Text('Save Semester'),
      ),
    );
  }

  Widget _buildSubjectCard(int index) {
    final subject = subjects[index];

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subject ${index + 1}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6C5CE7),
                  ),
                ),
                if (subjects.length > 1)
                  IconButton(
                    onPressed: () => _removeSubject(index),
                    icon: const Icon(Icons.delete, color: Colors.red),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Subject Name
            TextField(
              decoration: const InputDecoration(
                labelText: 'Subject Name',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              controller: TextEditingController(text: subject.subjectName)
                ..selection = TextSelection.collapsed(
                  offset: subject.subjectName.length,
                ),
              onChanged: (value) => _updateSubject(index, subjectName: value),
              onEditingComplete: _saveSemester,
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                // Credit Hours
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<int>(
                    value: subject.creditHours,
                    decoration: const InputDecoration(
                      labelText: 'Credits',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    items: creditOptions.map((credit) {
                      return DropdownMenuItem(
                        value: credit,
                        child: Text(credit.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        _updateSubject(index, creditHours: value);
                        _saveSemester();
                      }
                    },
                  ),
                ),

                const SizedBox(width: 12),

                // Grade
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    value: subject.letterGrade,
                    decoration: const InputDecoration(
                      labelText: 'Grade',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    items: gradeOptions.map((grade) {
                      return DropdownMenuItem(
                        value: grade,
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: _getGradeColor(grade),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(grade),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        _updateSubject(index, letterGrade: value);
                        _saveSemester();
                      }
                    },
                  ),
                ),

                const SizedBox(width: 12),

                // Grade Points Display
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getGradeColor(
                        subject.letterGrade,
                      ).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _getGradeColor(
                          subject.letterGrade,
                        ).withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          subject.gradePoints.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _getGradeColor(subject.letterGrade),
                          ),
                        ),
                        Text(
                          'GP',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSemesterNameDialog() {
    final TextEditingController nameController = TextEditingController(
      text: semesterName,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Edit Semester Name'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Semester Name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                semesterName = nameController.text.trim().isNotEmpty
                    ? nameController.text.trim()
                    : 'New Semester';
              });
              _saveSemester();
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
