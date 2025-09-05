import 'package:nu_result/features/result/domain/entities/examiner.dart';

class ExaminerModel extends Examiner {
  ExaminerModel({
    required super.registrationNumber,
    required super.name,
    required super.html,
  });

  Examiner copyWith({
    String? registrationNumber,
    String? name,
    List<String>? html,
  }) {
    return Examiner(
      registrationNumber: registrationNumber ?? this.registrationNumber,
      name: name ?? this.name,
      html: html ?? this.html,
    );
  }
}
