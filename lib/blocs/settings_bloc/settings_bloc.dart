import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:stepcounter/models/settings.dart';

part 'settings_event.dart';

/// This BLoC is used to store the settings.
/// It uses the HydratedMixin to persist the data when the app restarts.
class SettingsBloc extends Bloc<SettingsEvent, Settings> with HydratedMixin {
  SettingsBloc() : super(Settings());

  @override
  Stream<Settings> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is ToggleNotificationsEvent) {
      // Stream the same Settings object with a toggled showNotifications value
      yield state.copyWith(showNotifications: !state.notificationsEnabled);
    } else if (event is SetDailyGoalEvent) {
      // Stream the same Settings object with the new dailyGoal value
      yield state.copyWith(dailyGoal: event.dailyGoal);
    } else {
      print('Unknown event in Settings BLoC, ignoring it)');
    }
  }

  @override
  Settings? fromJson(Map<String, dynamic> json) {
    return Settings(
      notificationsEnabled: json['showNotifications'],
      dailyGoal: json['dailyGoal'],
    );
  }

  @override
  Map<String, dynamic>? toJson(Settings state) {
    return {
      'showNotifications': state.notificationsEnabled,
      'dailyGoal': state.dailyGoal,
    };
  }
}
