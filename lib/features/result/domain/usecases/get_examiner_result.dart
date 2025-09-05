import 'package:dartz/dartz.dart';
import 'package:nu_result/core/usecases/usecase.dart';
import 'package:nu_result/features/result/domain/entities/examiner.dart';
import 'package:nu_result/features/result/domain/repositories/examiner_repository.dart';

import '../../../../core/errors/failure.dart';

class GetExaminerResult implements UseCase<Examiner, Params1> {
  final ExaminerRepository repository;

  GetExaminerResult(this.repository);
  @override
  Future<Either<Failure, Examiner>> call(Params1 params) async {
    return await repository.getExaminerResult(params.registrationNumber, params.session!);
  }
}
