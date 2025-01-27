part of 'step_bloc.dart';

sealed class StepState extends Equatable {
  const StepState();

  @override
  List<Object> get props => [];
}

final class StepInitial extends StepState {}

final class StepLoading extends StepState {}

final class StepError extends StepState {}

final class StepDone extends StepState {}