part of 'step_bloc.dart';

sealed class StepsState extends Equatable {
  const StepsState();

  @override
  List<Object> get props => [];
}

final class StepInitial extends StepsState {}

final class StepLoading extends StepsState {}

final class StepError extends StepsState {}

// ignore: must_be_immutable
final class StepDone extends StepsState {
  String tokens;
  StepDone({required this.tokens});

  @override
  List<Object> get props => [tokens];
}
