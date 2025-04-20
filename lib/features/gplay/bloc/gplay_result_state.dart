part of 'gplay_result_bloc.dart';

sealed class GplayResultState extends Equatable {
  const GplayResultState();
  
  @override
  List<Object> get props => [];
}

final class GplayResultInitial extends GplayResultState {}

final class GplayResultLoading extends GplayResultState {}

final class GplayResultLoaded extends GplayResultState {
  final List<ResultModel> gplayResults;

  const GplayResultLoaded(this.gplayResults);

  @override
  List<Object> get props => [gplayResults];
}