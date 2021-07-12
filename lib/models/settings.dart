import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  late final bool showNotifications;
  late final int dailyGoal;

  // Setting the default values
  Settings({
    this.showNotifications = true,
    this.dailyGoal = 2000,
  });

  Settings copyWith({
    bool? showNotifications,
    int? dailyGoal,
  }) {
    return Settings(
      showNotifications: showNotifications ?? this.showNotifications,
      dailyGoal: dailyGoal ?? this.dailyGoal,
    );
  }

  @override
  List<Object> get props => [this.showNotifications, this.dailyGoal];
}
