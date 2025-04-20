import 'package:dartz/dartz.dart';
import '../error/failure.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}

class Params1 {
  final String registrationNumber;
  final String? session;
  Params1({required this.registrationNumber, this.session});
}
