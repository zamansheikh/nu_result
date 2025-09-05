import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'result_model.dart';

class Subject {
  final String subjectName;
  final int creditHours;
  final String letterGrade;

  const Subject({
    required this.subjectName,
    required this.creditHours,
    required this.letterGrade,
  });

  // Grade points calculation
  double get gradePoints {
    final gradePointMap = {
      'A+': 4.00,
      'A': 3.75,
      'A-': 3.50,
      'B+': 3.25,
      'B': 3.00,
      'B-': 2.75,
      'C+': 2.50,
      'C': 2.25,
      'D': 2.00,
      'F': 0.00,
    };
    return gradePointMap[letterGrade] ?? 0.0;
  }

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'subjectName': subjectName,
      'creditHours': creditHours,
      'letterGrade': letterGrade,
    };
  }

  static Subject fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectName: json['subjectName'],
      creditHours: json['creditHours'],
      letterGrade: json['letterGrade'],
    );
  }

  // CopyWith method for immutability
  Subject copyWith({
    String? subjectName,
    int? creditHours,
    String? letterGrade,
  }) {
    return Subject(
      subjectName: subjectName ?? this.subjectName,
      creditHours: creditHours ?? this.creditHours,
      letterGrade: letterGrade ?? this.letterGrade,
    );
  }
}

class Semester {
  final String semesterName;
  final List<Subject> subjects;

  const Semester({
    required this.semesterName,
    required this.subjects,
  });

  // Calculate SGPA
  double calculateSGPA() {
    double totalCreditHours = 0.0;
    double totalGradePoints = 0.0;

    for (final subject in subjects) {
      totalCreditHours += subject.creditHours;
      totalGradePoints += subject.gradePoints * subject.creditHours;
    }

    return totalCreditHours == 0 ? 0.0 : totalGradePoints / totalCreditHours;
  }

  // Calculate total credit hours
  int calculateTotalCreditHours() {
    return subjects.fold(0, (total, subject) => total + subject.creditHours);
  }

  // Calculate total subjects
  int calculateTotalSubjects() {
    return subjects.length;
  }

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'semesterName': semesterName,
      'subjects': subjects.map((subject) => subject.toJson()).toList(),
    };
  }

  static Semester fromJson(Map<String, dynamic> json) {
    return Semester(
      semesterName: json['semesterName'],
      subjects: (json['subjects'] as List)
          .map((subjectJson) => Subject.fromJson(subjectJson))
          .toList(),
    );
  }

  // Method to save to Shared Preferences
  Future<void> toSharedPref(String key) async {
    final jsonString = jsonEncode(toJson());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonString);
  }

  // Method to retrieve from Shared Preferences
  static Future<Semester?> fromSharedPref(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString == null) return null;
    final json = jsonDecode(jsonString);
    return Semester.fromJson(json);
  }

  // CopyWith method for immutability
  Semester copyWith({
    String? semesterName,
    List<Subject>? subjects,
  }) {
    return Semester(
      semesterName: semesterName ?? this.semesterName,
      subjects: subjects ?? this.subjects,
    );
  }

   // Convert ResultModel to Semester
  factory Semester.fromResultModel(ResultModel result) {
    List<Subject> subjects = result.courseGrades.map((courseGrade) {
      return Subject(
        subjectName: courseGrade.courseTitle,
        creditHours: int.tryParse(courseGrade.credit) ?? 0,
        letterGrade: courseGrade.letterGrade,
      );
    }).toList();

    return Semester(
      semesterName: "Semester - ${result.year}", // default or generated semester name
      subjects: subjects,
    );
  }
}
