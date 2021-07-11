import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stepcounter_event.dart';
part 'stepcounter_state.dart';

class StepcounterBloc extends Bloc<StepcounterEvent, StepcounterState> {
  StepcounterBloc() : super(StepcounterLoading());

  @override
  Stream<StepcounterState> mapEventToState(
    StepcounterEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
