import 'package:dartz/dartz.dart';
import 'package:nu_result/features/result/domain/entities/examiner.dart';
import 'package:nu_result/features/result/domain/entities/user.dart';

import '../../../../core/errors/failure.dart';

abstract class ExaminerRepository {
  Future<Either<Failure, Examiner>> getExaminerResult(
      String registrationNumber, String session);
  Future<Either<Failure, User>> getUserInfo(String registrationNumber);
}
