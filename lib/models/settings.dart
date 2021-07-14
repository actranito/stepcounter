import 'package:equatable/equatable.dart';

/// This model will hold all the settings available
class Settings extends Equatable {
  late final bool notificationsEnabled;
  late final int dailyGoal;

  // Setting the default values
  Settings({
    this.notificationsEnabled = true,
    this.dailyGoal = 2000,
  });

  Settings copyWith({
    bool? showNotifications,
    int? dailyGoal,
  }) {
    return Settings(
      notificationsEnabled: showNotifications ?? this.notificationsEnabled,
      dailyGoal: dailyGoal ?? this.dailyGoal,
    );
  }

  @override
  List<Object> get props => [this.notificationsEnabled, this.dailyGoal];
}
