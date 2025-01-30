part of 'step_bloc.dart';

sealed class StepsState extends Equatable {
  const StepsState();

  @override
  List<Object> get props => [];
}

final class StepInitial extends StepsState {}

final class StepLoading extends StepsState {}

final class StepError1 extends StepsState {}

final class StepError2 extends StepsState {}

final class StepError3 extends StepsState {}

// ignore: must_be_immutable
final class StepDone1 extends StepsState {
  String tokens;
  StepDone1({required this.tokens});

  @override
  List<Object> get props => [tokens];
}

final class StepDone2 extends StepsState {}

final class StepDone3 extends StepsState {}
