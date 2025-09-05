import 'package:dartz/dartz.dart';
import 'package:nu_result/features/result/data/datasources/examiner_remote_data_source.dart';
import 'package:nu_result/features/result/domain/entities/examiner.dart';
import 'package:nu_result/features/result/domain/entities/user.dart';
import 'package:nu_result/features/result/domain/repositories/examiner_repository.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';

class ExaminerRepositoryImpl implements ExaminerRepository {
  final ExaminerRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ExaminerRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Examiner>> getExaminerResult(
      String registrationNumber, String session) async {
    if (await networkInfo.isConnected) {
      try {
        final results = await remoteDataSource.getExaminerResult(
            registrationNumber, session);
        return Right(results);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      // Handle the case when the device is offline
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUserInfo(String registrationNumber) async {
    if (await networkInfo.isConnected) {
      try {
        final userInfo = await remoteDataSource.getUserInfo(registrationNumber);
        return Right(userInfo);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      // Handle the case when the device is offline
      return Left(ServerFailure());
    }
  }
}
