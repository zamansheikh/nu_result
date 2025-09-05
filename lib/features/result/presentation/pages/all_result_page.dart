import 'package:flutter/material.dart';

import '../../../../shared/models/result_model.dart';
import '../../../html_scrapper/presentation/pages/student_result_page.dart';

class AllResultPage extends StatefulWidget {
  final List<ResultModel> results;
  const AllResultPage({
    super.key,
    required this.results,
  });

  @override
  State<AllResultPage> createState() => _AllResultPageState();
}

class _AllResultPageState extends State<AllResultPage> {
  List<ResultModel> sortedResults = [];
  String examType(String type) {
    if (type == 'first_year') {
      return 'First Year';
    } else if (type == 'second_year') {
      return 'Second Year';
    } else if (type == 'third_year') {
      return 'Third Year';
    } else if (type == 'fourth_year') {
      return 'Fourth Year';
    } else {
      return 'Unknown';
    }
  }

  var firstYearResult = ResultModel(
    registrationNo: "",
    studentName: '',
    examType: 'First Year',
    year: '',
    courseGrades: [],
    college: '',
    session: '',
    studentType: '',
    subject: '',
    result: '',
  );
  var secondYearResult = ResultModel(
    registrationNo: "",
    studentName: '',
    examType: 'Second Year',
    year: '',
    courseGrades: [],
    college: '',
    session: '',
    studentType: '',
    subject: '',
    result: '',
  );
  var thirdYearResult = ResultModel(
    registrationNo: "",
    studentName: '',
    examType: 'Third Year',
    year: '',
    courseGrades: [],
    college: '',
    session: '',
    studentType: '',
    subject: '',
    result: '',
  );
  var fourthYearResult = ResultModel(
    registrationNo: "",
    studentName: '',
    examType: 'Fourth Year',
    year: '',
    courseGrades: [],
    college: '',
    session: '',
    studentType: '',
    subject: '',
    result: '',
  );

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

  List<String> firstYearPromotion = [];
  List<String> secondYearPromotion = [];
  List<String> thirdYearPromotion = [];
  List<String> fourthYearPromotion = [];

  void shorResultsByExamType() {
    for (var result in widget.results) {
      // Short result via year
      if (result.examType == 'first_year') {
        firstYearPromotion.add(result.result);

        firstYearResult = firstYearResult.copyWith(
          registrationNo: result.registrationNo,
          studentName: result.studentName,
          year: result.year,
          examType: "first_year",
          courseGrades: _mergeCourseGrades(
              firstYearResult.courseGrades, result.courseGrades),
          college: result.college,
          session: result.session,
          studentType: result.studentType,
          subject: result.subject,
          result: result.result,
        );
      } else if (result.examType == 'second_year') {
        secondYearPromotion.add(result.result);
        secondYearResult = secondYearResult.copyWith(
          registrationNo: result.registrationNo,
          studentName: result.studentName,
          examType: "second_year",
          year: result.year,
          courseGrades: _mergeCourseGrades(
              secondYearResult.courseGrades, result.courseGrades),
          college: result.college,
          session: result.session,
          studentType: result.studentType,
          subject: result.subject,
          result: result.result,
        );
      } else if (result.examType == 'third_year') {
        thirdYearPromotion.add(result.result);
        thirdYearResult = thirdYearResult.copyWith(
          registrationNo: result.registrationNo,
          studentName: result.studentName,
          examType: "third_year",
          year: result.year,
          courseGrades: _mergeCourseGrades(
              thirdYearResult.courseGrades, result.courseGrades),
          college: result.college,
          session: result.session,
          studentType: result.studentType,
          subject: result.subject,
          result: result.result,
        );
      } else if (result.examType == 'fourth_year') {
        fourthYearPromotion.add(result.result);
        fourthYearResult = fourthYearResult.copyWith(
          registrationNo: result.registrationNo,
          studentName: result.studentName,
          examType: "fourth_year",
          year: result.year,
          courseGrades: _mergeCourseGrades(
              fourthYearResult.courseGrades, result.courseGrades),
          college: result.college,
          session: result.session,
          studentType: result.studentType,
          subject: result.subject,
          result: result.result,
        );
      }
    }
    firstYearResult = firstYearResult.copyWith(
      result:
          firstYearPromotion.contains('Promoted') ? 'Promoted' : 'Not Promoted',
    );
    secondYearResult = secondYearResult.copyWith(
      result: secondYearPromotion.contains('Promoted')
          ? 'Promoted'
          : 'Not Promoted',
    );
    thirdYearResult = thirdYearResult.copyWith(
      result:
          thirdYearPromotion.contains('Promoted') ? 'Promoted' : 'Not Promoted',
    );
    fourthYearResult = fourthYearResult.copyWith(
      result: fourthYearPromotion.contains('Promoted')
          ? 'Promoted'
          : 'Not Promoted',
    );
    sortedResults = [
      if (firstYearResult.courseGrades.isNotEmpty) firstYearResult,
      if (secondYearResult.courseGrades.isNotEmpty) secondYearResult,
      if (thirdYearResult.courseGrades.isNotEmpty) thirdYearResult,
      if (fourthYearResult.courseGrades.isNotEmpty) fourthYearResult,
    ];
  }

  List<CourseGrade> _mergeCourseGrades(
      List<CourseGrade> existingGrades, List<CourseGrade> newGrades) {
    // Create a map to store merged grades, using courseCode as the key
    final Map<String, CourseGrade> mergedGradesMap = {
      for (var grade in existingGrades) grade.courseCode: grade
    };

    // Merge the new grades with the existing grades
    for (var newGrade in newGrades) {
      if (mergedGradesMap.containsKey(newGrade.courseCode)) {
        var existingGrade = mergedGradesMap[newGrade.courseCode]!;
        // Keep the grade with the higher grade point
        if (getGradePoint(newGrade.letterGrade) >
            getGradePoint(existingGrade.letterGrade)) {
          mergedGradesMap[newGrade.courseCode] = newGrade;
        }
      } else {
        mergedGradesMap[newGrade.courseCode] = newGrade;
      }
    }

    // Return the merged grades as a list
    return mergedGradesMap.values.toList();
  }

  @override
  void initState() {
    shorResultsByExamType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (sortedResults.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: PageView.builder(
        itemCount: sortedResults.length,
        itemBuilder: (context, index) {
          return StudentResultPage(
            result: sortedResults[index],
            typeDetails:
                "${examType(sortedResults[index].examType)} (${sortedResults[index].year})",
            registration: sortedResults[index].registrationNo,
            roll: "",
          );
        },
      ),
    );
  }
}
