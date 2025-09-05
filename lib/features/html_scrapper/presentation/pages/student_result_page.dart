import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../../core/constants/constant.dart';
import '../../../../shared/models/result_model.dart';
import 'result_sevice.dart';

class StudentResultPage extends StatefulWidget {
  final ResultModel result;
  final String typeDetails;
  final String registration;
  final String roll;

  const StudentResultPage({
    super.key,
    required this.result,
    required this.typeDetails,
    required this.registration,
    required this.roll,
  });

  @override
  State<StudentResultPage> createState() => _StudentResultPageState();
}

class _StudentResultPageState extends State<StudentResultPage> {
  double calculateGPA(List<CourseGrade> courseGradesAll) {
    List<CourseGrade> courseGrades = courseGradesAll;
    double totalPointsSecured = 0;
    double totalCredits = 0;

    for (var course in courseGrades) {
      double credit = 0.0;
      try {
        credit = double.parse(course.credit);
      } catch (e) {
        credit = 0.0;
      }
      double gradePoint = getGradePoint(course.letterGrade);
      totalPointsSecured += credit * gradePoint;
      totalCredits += credit;
    }

    return totalPointsSecured / totalCredits;
  }

  double getGradePoint(String letterGrade) {
    switch (letterGrade) {
      case 'A+':
        return 4.00;
      case 'A':
        return 3.75;
      case 'A-':
        return 3.50;
      case 'B+':
        return 3.25;
      case 'B':
        return 3.00;
      case 'B-':
        return 2.75;
      case 'C+':
        return 2.50;
      case 'C':
        return 2.25;
      case 'D':
        return 2.00;
      case 'F':
        return 0.00;
      default:
        return 0.00;
    }
  }

  Widget result() {
    bool isFail = false;
    for (var course in widget.result.courseGrades) {
      if (course.letterGrade == 'F' || course.letterGrade == 'Fail') {
        isFail = true;
        break;
      }
    }

    if (!isFail) {
      return Text('Result: Congratulations! Promoted',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green));
    } else {
      return Text('Result: Sorry! No Promoted',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    double cgpa = calculateGPA(widget.result.courseGrades);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 100,
        title: Text('${widget.typeDetails} - CGPA'),
        actions: [
          Image.asset(
           NU_LOGO_ICON,
            width: 40,
            height: 40,
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading Section
              Card(
                shadowColor: Colors.blueGrey,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Student Name: ${widget.result.studentName}',
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('College: ${widget.result.college}',
                          style: const TextStyle(fontSize: 18)),
                      Text(
                        'Registration No.: ${widget.registration}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text('Session: ${widget.result.session}',
                          style: const TextStyle(fontSize: 18)),
                      Text('Student Type: ${widget.result.studentType}',
                          style: const TextStyle(fontSize: 18)),
                      Text('Subject: ${widget.result.subject}',
                          style: const TextStyle(fontSize: 18)),
                      Text('Exam: ${widget.typeDetails}',
                          style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text('Result: ${widget.result.result}',
                          style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Courses and Grades Section
              const Text(
                'Courses & Grades:',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
              const SizedBox(height: 8),

              // Table for Courses and Grades
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder.all(
                        color: Colors.blueAccent.withValues(alpha: 0.3),
                        width: 1.5), // Add borders to the table
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                    },
                    children: [
                      // Table Header
                      TableRow(
                        decoration:
                            BoxDecoration(color: Colors.blueAccent[100]),
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Course Title',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Course Code',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Credit',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Grade',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ],
                      ),

                      // Generate rows for each course
                      for (var course in widget.result.courseGrades)
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(course.courseTitle),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(course.courseCode),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(course.credit),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(course.letterGrade),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),

              const Divider(),

              // CGPA Section
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text('CGPA (Year): ${cgpa.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent)),
              ),

              const SizedBox(height: 20),

              // Download PDF Button
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final Uint8List byteList =
                          await ResultService().generateResult(
                        result: widget.result,
                        typedetails: widget.typeDetails,
                        registration: widget.registration,
                      );
                      await ResultService().saveResult(
                          widget.result.registrationNo.isEmpty
                              ? widget.result.studentName.split(' ').first
                              : widget.result.registrationNo,
                          byteList);
                    },
                    icon: const Icon(Icons.download, size: 24),
                    label: const Text('Download PDF',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      iconColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
