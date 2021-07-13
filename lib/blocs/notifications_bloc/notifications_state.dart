part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsSettingsState extends NotificationsState {
  final bool showDailyGoalEndOfDayNotification;

  NotificationsSettingsState(this.showDailyGoalEndOfDayNotification);

  @override
  List<Object> get props => [this.showDailyGoalEndOfDayNotification];
}
