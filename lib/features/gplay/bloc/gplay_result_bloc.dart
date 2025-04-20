import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nu_result/core/models/result_model.dart';

part 'gplay_result_event.dart';
part 'gplay_result_state.dart';

class GplayResultBloc extends Bloc<GplayResultEvent, GplayResultState> {
  GplayResultBloc() : super(GplayResultInitial()) {
    on<FetchGplayResult>((event, emit) {});
  }
}
