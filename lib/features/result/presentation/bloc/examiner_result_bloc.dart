import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nu_result/core/usecases/usecase.dart';
import 'package:nu_result/features/result/domain/entities/examiner.dart';
import 'package:nu_result/features/result/domain/entities/user.dart';
import 'package:nu_result/features/result/domain/usecases/get_examiner_result.dart';
import 'package:nu_result/features/result/domain/usecases/get_user_info.dart';

part 'examiner_result_event.dart';
part 'examiner_result_state.dart';

class ExaminerResultBloc
    extends Bloc<ExaminerResultEvent, ExaminerResultState> {
  final GetExaminerResult getExaminerResultUseCase;
  final GetUserInfo getUserInfoUseCase;

  ExaminerResultBloc(
      {required this.getUserInfoUseCase,
      required this.getExaminerResultUseCase})
      : super(ExaminerResultInitial()) {
    on<ExaminerResultEvent>((event, emit) => emit(ExaminerResultLoading()));
    on<GetExaminerResultEvent>((event, emit) async {
      final result = await getExaminerResultUseCase(Params1(
          registrationNumber: event.registrationNumber,
          session: event.session));
      result.fold(
          (failure) => emit(ExaminerResultError(message: failure.toString())),
          (examiner) => emit(ExaminerResultLoaded(examiner: examiner)));
    });
    on<GetUsrInfoEvent>((event, emit) async {
      final info = await getUserInfoUseCase(
        Params1(registrationNumber: event.registrationNumber),
      );
      info.fold(
        (failure) => emit(ExaminerResultError(message: failure.toString())),
        (user) => emit(UserInfoLoaded(user: user)),
      );
    });
  }
}
