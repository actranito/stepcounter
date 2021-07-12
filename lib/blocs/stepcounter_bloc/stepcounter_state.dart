part of 'stepcounter_bloc.dart';

abstract class StepcounterState extends Equatable {
  const StepcounterState();

  @override
  List<Object> get props => [];
}

class StepcounterLoading extends StepcounterState {}

class StepcounterLoaded extends StepcounterState {
  final StepcounterData stepcounterData;

  StepcounterLoaded(this.stepcounterData);

  @override
  List<Object> get props => [this.stepcounterData];
}

class StepcounterError extends StepcounterState {}
