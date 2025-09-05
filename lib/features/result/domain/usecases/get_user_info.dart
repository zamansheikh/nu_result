import 'package:dartz/dartz.dart';
import 'package:nu_result/core/usecases/usecase.dart';
import 'package:nu_result/features/result/domain/entities/user.dart';
import 'package:nu_result/features/result/domain/repositories/examiner_repository.dart';

import '../../../../core/errors/failure.dart';

class GetUserInfo implements UseCase<User, Params1> {
  final ExaminerRepository repository;

  GetUserInfo(this.repository);
  @override
  Future<Either<Failure, User>> call(Params1 params) async {
    return await repository.getUserInfo(params.registrationNumber);
  }
}

