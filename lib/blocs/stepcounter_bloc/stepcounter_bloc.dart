import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stepcounter/models/stepcounter_data.dart';
import 'package:stepcounter/services/mock_stepCounter.dart';

part 'stepcounter_event.dart';
part 'stepcounter_state.dart';

class StepcounterBloc extends Bloc<StepcounterEvent, StepcounterState> {
  StepcounterBloc() : super(StepcounterLoading()) {
    MockStepCounter mockStepCounter = MockStepCounter();
    mockStepCounter.fetchCountFromLocalStorage();
    mockStepCounter.getDelayedRandomValue().listen((event) {
      this.updateData(event);
    });
  }

  @override
  Stream<StepcounterState> mapEventToState(
    StepcounterEvent event,
  ) async* {
    try {
      if (event is UpdateStepcounterDataEvent) {
        yield StepcounterLoaded(event.stepcounterData);
      } else {
        print('Unknown event in Stepcounter BLoC, ignoring it)');
      }
    } catch (e) {
      yield StepcounterError();
    }
  }

  void updateData(StepcounterData stepcounterData) {
    this.add(UpdateStepcounterDataEvent(stepcounterData));
  }
}
