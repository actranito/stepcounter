part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class SetNotificationEvent extends NotificationsEvent {}

class CancelNotificationEvent extends NotificationsEvent {}
