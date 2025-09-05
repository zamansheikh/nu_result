part of 'examiner_result_bloc.dart';

sealed class ExaminerResultState extends Equatable {
  const ExaminerResultState();

  @override
  List<Object> get props => [];
}

final class ExaminerResultInitial extends ExaminerResultState {}

final class ExaminerResultLoading extends ExaminerResultState {}

final class ExaminerResultLoaded extends ExaminerResultState {
  final Examiner examiner;

  const ExaminerResultLoaded({required this.examiner});

  @override
  List<Object> get props => [examiner];
}

final class ExaminerResultError extends ExaminerResultState {
  final String message;

  const ExaminerResultError({required this.message});

  @override
  List<Object> get props => [message];
}

final class UserInfoLoaded extends ExaminerResultState {
  final User user;

  const UserInfoLoaded({required this.user});

  @override
  List<Object> get props => [user];
}
