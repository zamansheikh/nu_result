part of 'examiner_result_bloc.dart';

sealed class ExaminerResultEvent extends Equatable {
  const ExaminerResultEvent();

  @override
  List<Object> get props => [];
}

class GetExaminerResultEvent extends ExaminerResultEvent {
  final String registrationNumber;
  final String session;

  const GetExaminerResultEvent(
      {required this.session, required this.registrationNumber});

  @override
  List<Object> get props => [registrationNumber];
}

class GetUsrInfoEvent extends ExaminerResultEvent {
  final String registrationNumber;

  const GetUsrInfoEvent({
    required this.registrationNumber,
  });

  @override
  List<Object> get props => [registrationNumber];
}
