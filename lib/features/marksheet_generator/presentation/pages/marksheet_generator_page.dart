import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../shared/models/semester.dart';

class MarksheetGeneratorPage extends StatefulWidget {
  const MarksheetGeneratorPage({super.key});

  @override
  State<MarksheetGeneratorPage> createState() => _MarksheetGeneratorPageState();
}

class _MarksheetGeneratorPageState extends State<MarksheetGeneratorPage> {
  final _formKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();
  final _registrationController = TextEditingController();
  final _sessionController = TextEditingController();
  final _collegeController = TextEditingController();

  List<String> availableSemesters = [];
  List<String> selectedSemesters = [];
  bool isLoading = true;
  bool isGenerating = false;

  @override
  void initState() {
    super.initState();
    _loadAvailableSemesters();
  }

  @override
  void dispose() {
    _studentNameController.dispose();
    _registrationController.dispose();
    _sessionController.dispose();
    _collegeController.dispose();
    super.dispose();
  }

  Future<void> _loadAvailableSemesters() async {
    setState(() => isLoading = true);

    try {
      // Load all semester keys that have data
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs
          .getKeys()
          .where(
            (key) => key.startsWith('semester_') || key.startsWith('year_'),
          )
          .toList();

      List<String> validSemesters = [];

      for (String key in keys) {
        final semester = await Semester.fromSharedPref(key);
        if (semester != null && semester.subjects.isNotEmpty) {
          validSemesters.add(key);
        }
      }

      setState(() {
        availableSemesters = validSemesters;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Future<void> _generateMarksheet() async {
    if (!_formKey.currentState!.validate() || selectedSemesters.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill all required fields and select at least one semester',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isGenerating = true);

    try {
      final pdf = pw.Document();
      final logoBytes = await rootBundle.load('assets/icon/icon.jpg');
      final logoImage = pw.MemoryImage(logoBytes.buffer.asUint8List());

      // Load selected semester data
      List<Semester> semesters = [];
      for (String key in selectedSemesters) {
        final semester = await Semester.fromSharedPref(key);
        if (semester != null) {
          semesters.add(semester);
        }
      }

      // Calculate overall statistics
      double totalGradePoints = 0.0;
      int totalCredits = 0;

      for (Semester semester in semesters) {
        double sgpa = semester.calculateSGPA();
        int credits = semester.calculateTotalCreditHours();
        totalGradePoints += sgpa * credits;
        totalCredits += credits;
      }

      double cumulativeCgpa = totalCredits > 0
          ? totalGradePoints / totalCredits
          : 0.0;

      // Create PDF pages
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(30),
          build: (pw.Context context) {
            return [
              // Header
              _buildPdfHeader(logoImage),

              pw.SizedBox(height: 30),

              // Student Information
              _buildStudentInfo(),

              pw.SizedBox(height: 20),

              // Semester Results
              ...semesters.map((semester) => _buildSemesterTable(semester)),

              pw.SizedBox(height: 20),

              // Overall Results
              _buildOverallResults(
                cumulativeCgpa,
                totalCredits,
                semesters.length,
              ),

              pw.SizedBox(height: 30),

              // Footer
              _buildPdfFooter(),
            ];
          },
        ),
      );

      // Save and open PDF
      final output = await getTemporaryDirectory();
      final file = File(
        '${output.path}/marksheet_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      await file.writeAsBytes(await pdf.save());

      await OpenFile.open(file.path);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Marksheet generated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating marksheet: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => isGenerating = false);
    }
  }

  pw.Widget _buildPdfHeader(pw.ImageProvider logoImage) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Image(logoImage, width: 60, height: 60),
        pw.SizedBox(width: 20),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text(
              'National University, Bangladesh',
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              'Official Academic Transcript',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.normal,
              ),
            ),
            pw.SizedBox(height: 2),
            pw.Container(width: 100, height: 2, color: PdfColors.blue),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildStudentInfo() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Student Information',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Student Name: ${_studentNameController.text}'),
              pw.Text('Registration No: ${_registrationController.text}'),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Session: ${_sessionController.text}'),
              pw.Text('College: ${_collegeController.text}'),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildSemesterTable(Semester semester) {
    double sgpa = semester.calculateSGPA();
    int totalCredits = semester.calculateTotalCreditHours();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 20),
        pw.Text(
          semester.semesterName,
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 10),
        pw.Table(
          border: pw.TableBorder.all(),
          columnWidths: {
            0: const pw.FlexColumnWidth(3),
            1: const pw.FlexColumnWidth(1),
            2: const pw.FlexColumnWidth(1),
            3: const pw.FlexColumnWidth(1),
          },
          children: [
            // Header
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey200),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    'Subject Name',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    'Credits',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    'Grade',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    'Grade Points',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ],
            ),
            // Subject rows
            ...semester.subjects
                .map(
                  (subject) => pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(subject.subjectName),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(subject.creditHours.toString()),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(subject.letterGrade),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(subject.gradePoints.toStringAsFixed(2)),
                      ),
                    ],
                  ),
                )
                .toList(),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text(
              'SGPA: ${sgpa.toStringAsFixed(2)} | Credits: $totalCredits',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildOverallResults(
    double cgpa,
    int totalCredits,
    int totalSemesters,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(15),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.blue, width: 2),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
        children: [
          pw.Column(
            children: [
              pw.Text(
                'Cumulative CGPA',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                cgpa.toStringAsFixed(2),
                style: const pw.TextStyle(fontSize: 18),
              ),
            ],
          ),
          pw.Column(
            children: [
              pw.Text(
                'Total Credits',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                totalCredits.toString(),
                style: const pw.TextStyle(fontSize: 18),
              ),
            ],
          ),
          pw.Column(
            children: [
              pw.Text(
                'Total Semesters',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                totalSemesters.toString(),
                style: const pw.TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildPdfFooter() {
    return pw.Column(
      children: [
        pw.Divider(),
        pw.SizedBox(height: 10),
        pw.Text(
          'Generated by NU Result App',
          style: const pw.TextStyle(fontSize: 12),
        ),
        pw.Text(
          'Generated on: ${DateTime.now().toString().split('.')[0]}',
          style: const pw.TextStyle(fontSize: 10),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          'Developed by Zaman Sheikh',
          style: const pw.TextStyle(fontSize: 10),
        ),
      ],
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
            colors: [Color(0xFFE17055), Color(0xFFFD79A8)],
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
                        'Marksheet Generator',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48),
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
                      : availableSemesters.isEmpty
                      ? _buildEmptyState()
                      : _buildGeneratorForm(),
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
          Icon(Icons.picture_as_pdf_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No Semester Data Available',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Text(
            'Add some semesters in CGPA Calculator first',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneratorForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Student Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Student Name
            TextFormField(
              controller: _studentNameController,
              decoration: const InputDecoration(
                labelText: 'Student Name *',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter student name';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Registration Number
            TextFormField(
              controller: _registrationController,
              decoration: const InputDecoration(
                labelText: 'Registration Number *',
                prefixIcon: Icon(Icons.badge),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter registration number';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                // Session
                Expanded(
                  child: TextFormField(
                    controller: _sessionController,
                    decoration: const InputDecoration(
                      labelText: 'Session *',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter session';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // College
                Expanded(
                  child: TextFormField(
                    controller: _collegeController,
                    decoration: const InputDecoration(
                      labelText: 'College *',
                      prefixIcon: Icon(Icons.school),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter college name';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Semester Selection
            const Text(
              'Select Semesters to Include',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose which semesters to include in the marksheet',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),

            // Semester List
            ...availableSemesters.map((key) {
              return FutureBuilder<Semester?>(
                future: Semester.fromSharedPref(key),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 60,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final semester = snapshot.data;
                  if (semester == null) return const SizedBox.shrink();

                  bool isSelected = selectedSemesters.contains(key);
                  double sgpa = semester.calculateSGPA();
                  int credits = semester.calculateTotalCreditHours();

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: CheckboxListTile(
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            selectedSemesters.add(key);
                          } else {
                            selectedSemesters.remove(key);
                          }
                        });
                      },
                      title: Text(
                        semester.semesterName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'SGPA: ${sgpa.toStringAsFixed(2)} • Credits: $credits',
                      ),
                      secondary: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isSelected
                                ? [
                                    const Color(0xFFE17055),
                                    const Color(0xFFFD79A8),
                                  ]
                                : [Colors.grey[300]!, Colors.grey[400]!],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.school, color: Colors.white),
                      ),
                    ),
                  );
                },
              );
            }).toList(),

            const SizedBox(height: 32),

            // Generate Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: isGenerating ? null : _generateMarksheet,
                icon: isGenerating
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.picture_as_pdf),
                label: Text(
                  isGenerating ? 'Generating...' : 'Generate Marksheet',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE17055),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            if (selectedSemesters.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE17055).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE17055).withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Color(0xFFE17055)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${selectedSemesters.length} semester${selectedSemesters.length != 1 ? 's' : ''} selected for marksheet generation',
                        style: const TextStyle(
                          color: Color(0xFFE17055),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
