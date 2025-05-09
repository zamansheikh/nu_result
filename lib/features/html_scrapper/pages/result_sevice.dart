import 'dart:io';

import 'package:flutter/services.dart';
import 'package:nu_result/core/models/result_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
// import 'package:flutter/services.dart' show rootBundle;

class ResultService {
  Future<Uint8List> generateResult(
      {required ResultModel result,
      required String typedetails,
      required String registration}) async {
    final imageBytes = await rootBundle.load('assets/nu_logo_small.png');
    final imageqrBytes = await rootBundle.load('assets/qr.png');
    final image = pw.MemoryImage(imageBytes.buffer.asUint8List());
    final imageqr = pw.MemoryImage(imageqrBytes.buffer.asUint8List());
    final pdf = pw.Document();

    // Add a page to the PDF with the student details and the result table
    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.fromLTRB(30, 20, 30, 20),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Stack(
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Center(
                    child: pw.Image(
                      image,
                      width: 150,
                    ),
                  ),
                  // Title
                  pw.Center(
                    child: pw.Text('Student Transcript',
                        style: pw.TextStyle(
                            fontSize: 24, fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Center(
                    child: pw.Text(typedetails,
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  ),

                  pw.SizedBox(height: 10),

                  // Student details
                  pw.Text('Student Name: ${result.studentName}',
                      style: pw.TextStyle(
                          fontSize: 18, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 10),
                  pw.Text('Registration No.: $registration',
                      style: const pw.TextStyle(fontSize: 16)),
                  pw.Text('Session: ${result.session}',
                      style: const pw.TextStyle(fontSize: 16)),
                  pw.Text('College: ${result.college}',
                      style: const pw.TextStyle(fontSize: 16)),
                  pw.Text('Student Type: ${result.studentType}',
                      style: const pw.TextStyle(fontSize: 16)),
                  pw.Text('Subject: ${result.subject}',
                      style: const pw.TextStyle(fontSize: 16)),
                  pw.Text('Result: ${result.result}',
                      style: const pw.TextStyle(fontSize: 16)),

                  pw.SizedBox(height: 20),

                  // Table for courses and grades
                  pw.TableHelper.fromTextArray(
                    headers: ['Course Title', 'Course Code', 'Credit', 'Grade'],
                    data: result.courseGrades.map((course) {
                      return [
                        course.courseTitle,
                        course.courseCode,
                        course.credit,
                        course.letterGrade
                      ];
                    }).toList(),
                    cellStyle: pw.TextStyle(fontSize: 12),
                    headerStyle: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    headerDecoration: const pw.BoxDecoration(
                      color: pw.GridPaper.lineColor,
                    ),
                    border: pw.TableBorder.all(),
                    cellAlignment: pw.Alignment.centerLeft,
                    columnWidths: {
                      0: pw.FlexColumnWidth(2), // Course Title column
                    },
                  ),

                  pw.SizedBox(height: 20),

                  // CGPA
                  pw.Text(
                    'CGPA: ${_calculateGPA(result.courseGrades).toStringAsFixed(2)}',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold),
                  ),
                  // App Credit & Dev Credit
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'Generated by NU Result App _ Developed by Zaman Sheikh\nScan QR Code to download the app',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),

              // QR Code
              pw.Positioned(
                right: 0,
                top: 0,
                child: pw.Image(
                  imageqr,
                  width: 100,
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  double _calculateGPA(List<CourseGrade> courseGradesAll) {
    List<CourseGrade> courseGrades = courseGradesAll;
    double totalPointsSecured = 0;
    double totalCredits = 0;

    for (var course in courseGrades) {
      double credit = double.parse(course.credit);
      double gradePoint = _getGradePoint(course.letterGrade);
      totalPointsSecured += credit * gradePoint;
      totalCredits += credit;
    }

    return totalPointsSecured / totalCredits;
  }

  double _getGradePoint(String letterGrade) {
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

  Future<void> saveResult(String fileName, Uint8List byteList) async {
    final Directory output = await getApplicationDocumentsDirectory();
    final String filePath = '${output.path}/$fileName.pdf';
    final File file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
  }
}
