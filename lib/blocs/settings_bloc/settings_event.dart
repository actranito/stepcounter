part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

/// Event used to toggle the showNotifications setting
class ToggleNotificationsEvent extends SettingsEvent {}

/// Event used to set the steps Daily Goal
class SetDailyGoalEvent extends SettingsEvent {
  late final int dailyGoal;

  SetDailyGoalEvent({
    required this.dailyGoal,
  });

  @override
  List<Object> get props => [this.dailyGoal];
}
