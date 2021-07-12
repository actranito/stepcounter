part of 'stepcounter_bloc.dart';

abstract class StepcounterEvent extends Equatable {
  const StepcounterEvent();

  @override
  List<Object> get props => [];
}

class UpdateStepcounterDataEvent extends StepcounterEvent {
  final StepcounterData stepcounterData;

  UpdateStepcounterDataEvent(this.stepcounterData);

  @override
  List<Object> get props => [this.stepcounterData];
}
