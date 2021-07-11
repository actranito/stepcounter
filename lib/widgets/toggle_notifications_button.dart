import 'package:flutter/material.dart';
import 'package:stepcounter/blocs/settings_bloc/settings_bloc.dart';
import 'package:stepcounter/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleNotificationsButton extends StatelessWidget {
  const ToggleNotificationsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Listen to changes in the Settings.showNotifications value
    bool showNotifications =
        (context).watch<SettingsBloc>().state.showNotifications;

    return IconButton(
      onPressed: () {
        (context).read<SettingsBloc>().add(ToggleNotificationsEvent());
      },
      icon: Icon(
        showNotifications
            ? Icons.notifications_off_outlined
            : Icons.notifications_outlined,
        color: AppColors.DARK_BLUE,
        size: 26.0,
      ),
    );
  }
}
