part of 'gplay_result_bloc.dart';

sealed class GplayResultEvent extends Equatable {
  const GplayResultEvent();

  @override
  List<Object> get props => [];
}



final class FetchGplayResult extends GplayResultEvent {
  final ResultModel gplayResults;

  const FetchGplayResult(this.gplayResults);

  @override
  List<Object> get props => [gplayResults];
}