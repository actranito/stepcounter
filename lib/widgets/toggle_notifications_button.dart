import 'package:flutter/material.dart';
import 'package:stepcounter/blocs/settings_bloc/settings_bloc.dart';
import 'package:stepcounter/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepcounter/models/settings.dart';

class ToggleNotificationsButton extends StatelessWidget {
  const ToggleNotificationsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Listen to changes in the Settings.showNotifications value
    bool showNotifications =
        (context).watch<SettingsBloc>().state.notificationsEnabled;

    return BlocListener<SettingsBloc, Settings>(
      // Listen to changes in the notificationsEnabled variable
      // and display a snackbar when the value changes
      listenWhen: (previous, current) =>
          previous.notificationsEnabled != current.notificationsEnabled,
      listener: (context, state) {
        if (state.notificationsEnabled) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Notifications enabled'),
              duration: Duration(seconds: 1),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Notifications disabled'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      child: IconButton(
        onPressed: () {
          // Add the ToggleNotificationsEvent to the Settings bloc
          (context).read<SettingsBloc>().add(ToggleNotificationsEvent());
        },
        icon: Icon(
          showNotifications
              ? Icons.notifications_outlined
              : Icons.notifications_off_outlined,
          color: AppColors.DARK_BLUE,
          size: 26.0,
        ),
      ),
    );
  }
}
