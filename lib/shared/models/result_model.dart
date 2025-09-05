import 'semester.dart';

class ResultModel {
  final String studentName;
  final String college;
  final String registrationNo;
  final String session;
  final String studentType;
  final String subject;
  final String result;
  final String examType;
  final String year;
  final List<CourseGrade> courseGrades;

  ResultModel({
    required this.studentName,
    required this.college,
    required this.registrationNo,
    required this.session,
    required this.studentType,
    required this.subject,
    required this.result,
    required this.examType,
    required this.year,
    required this.courseGrades,
  });

  ResultModel copyWith({
    String? studentName,
    String? college,
    String? registrationNo,
    String? session,
    String? studentType,
    String? subject,
    String? result,
    String? examType,
    String? year,
    List<CourseGrade>? courseGrades,
  }) {
    return ResultModel(
      studentName: studentName ?? this.studentName,
      college: college ?? this.college,
      registrationNo: registrationNo ?? this.registrationNo,
      session: session ?? this.session,
      studentType: studentType ?? this.studentType,
      subject: subject ?? this.subject,
      result: result ?? this.result,
      examType: examType ?? this.examType,
      year: year ?? this.year,
      courseGrades: courseGrades ?? this.courseGrades,
    );
  }

  // Convert Semester to ResultModel
  factory ResultModel.fromSemesterModel(Semester semester) {
    List<CourseGrade> courseGrades = semester.subjects.map((subject) {
      return CourseGrade(
        courseCode: "Code", // default or calculated course code
        courseTitle: subject.subjectName,
        credit: subject.creditHours.toString(),
        letterGrade: subject.letterGrade,
      );
    }).toList();

    return ResultModel(
      studentName: "Student Name", // dummy data
      college: "College Name", // dummy data
      registrationNo: "Reg No", // dummy data
      session: "Session", // dummy data
      studentType: "Type", // dummy data
      subject: "Subject", // dummy data
      result: "Result", // dummy data
      examType: "Exam Type", // dummy data
      year: semester.semesterName
          .split(" ")
          .last, // extract year from semesterName if available
      courseGrades: courseGrades,
    );
  }

  @override
  String toString() {
    return 'ResultModel(studentName: $studentName, college: $college, registrationNo: $registrationNo, session: $session, studentType: $studentType, subject: $subject, result: $result, courseGrades: $courseGrades)';
  }
}

class CourseGrade {
  final String courseCode;
  final String courseTitle;
  final String credit;
  final String letterGrade;

  CourseGrade({
    required this.courseCode,
    required this.courseTitle,
    required this.credit,
    required this.letterGrade,
  });

  CourseGrade copyWith({
    String? courseCode,
    String? courseTitle,
    String? credit,
    String? letterGrade,
  }) {
    return CourseGrade(
      courseCode: courseCode ?? this.courseCode,
      courseTitle: courseTitle ?? this.courseTitle,
      credit: credit ?? this.credit,
      letterGrade: letterGrade ?? this.letterGrade,
    );
  }

  @override
  String toString() {
    return 'CourseGrade(courseCode: $courseCode, courseTitle: $courseTitle, credit: $credit, letterGrade: $letterGrade)';
  }
}
