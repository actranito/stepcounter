import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stepcounter/blocs/settings_bloc/settings_bloc.dart';
import 'package:stepcounter/blocs/stepcounter_bloc/stepcounter_bloc.dart';
import 'package:stepcounter/models/settings.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final SettingsBloc _settingsBloc;
  final StepcounterBloc _stepcounterBloc;
  late StreamSubscription _settingsSubscription;
  late StreamSubscription _stepcounterSubstricption;

  NotificationsBloc(this._settingsBloc, this._stepcounterBloc)
      : super(NotificationsSettingsState(false)) {
    // We will update the notification status at the start of the brick
    // and whenever on the of subscribed blocs changes its state
    this.updateNotification();
    this._settingsSubscription = this._settingsBloc.stream.listen((event) {
      this.updateNotification();
    });
    this._stepcounterSubstricption =
        this._stepcounterBloc.stream.listen((event) {
      this.updateNotification();
    });
  }

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    try {
      if (event is SetNotificationEvent) {
        yield NotificationsSettingsState(true);
      } else if (event is CancelNotificationEvent) {
        yield NotificationsSettingsState(false);
      } else {
        print('Unknown event in Notifications BLoC, ignoring it)');
      }
    } catch (e) {
      // If something went wrong, disable the notifications
      yield NotificationsSettingsState(false);
    }
  }

  @override
  Future<void> close() {
    this._settingsSubscription.cancel();
    this._stepcounterSubstricption.cancel();
    return super.close();
  }

  void updateNotification() {
    StepcounterState stepcounterState = this._stepcounterBloc.state;

    // If we have loaded the step info from the stepcounter sensor we can check
    // if the notification can be set or canceled
    if (stepcounterState is StepcounterLoaded) {
      int steps = stepcounterState.stepcounterData.steps;
      Settings settings = this._settingsBloc.state;

      // We will only show the notification when the notifications are enabled
      // and if the dailyStepCount is less than the dailyGoal
      if (settings.notificationsEnabled && steps < settings.dailyGoal) {
        this.add(SetNotificationEvent());
      } else {
        this.add(CancelNotificationEvent());
      }
    }
  }
}
