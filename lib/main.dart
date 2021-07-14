import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stepcounter/blocs/notifications_bloc/notifications_bloc.dart';
import 'package:stepcounter/blocs/settings_bloc/settings_bloc.dart';
import 'package:stepcounter/blocs/stepcounter_bloc/stepcounter_bloc.dart';
import 'package:stepcounter/views/stepcounter_view.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

const NOTIFICATION_ID_8PM = 0;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  // Setting up the Hydrated BLoC storage
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initializeNotificationSettings();
    tz.initializeTimeZones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stepcounter',
      theme: ThemeData(
        fontFamily: 'Lato',
      ),

      /// Providing the Settings and Stepcounter BLoCs first so that we can pass
      ///  it to the Notifications BLoC when we provide it. The NOtifications BLoC will
      /// then listen to state changes that happen in both Settings and
      /// Stepcounter BLoCs.
      home: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(),
          ),
          BlocProvider<StepcounterBloc>(
            create: (context) => StepcounterBloc(),
          ),
        ],
        child: Builder(
          builder: (context) {
            // Getting an instance of settings and stepcounter blocs to pass
            // it to the constructor of the notifications bloc
            SettingsBloc settingsBloc = (context).read<SettingsBloc>();
            StepcounterBloc stepcounterBloc = (context).read<StepcounterBloc>();

            return BlocProvider<NotificationsBloc>(
                lazy: false,
                create: (context) => NotificationsBloc(
                      settingsBloc,
                      stepcounterBloc,
                    ),
                child: Builder(
                  builder: (context) {
                    return BlocListener<NotificationsBloc, NotificationsState>(
                      listener: (context, state) async {
                        bool showNotification =
                            (state as NotificationsSettingsState)
                                .showDailyGoalEndOfDayNotification;
                        if (showNotification) {
                          await setNotification();
                        } else {
                          await cancelNotification();
                        }
                      },
                      child: StepcounterView(),
                    );
                  },
                ));
          },
        ),
      ),
    );
  }

  // This method is used to set the notification for 8pm
  Future<void> setNotification() async {
    // Get the date for today at 8pm
    DateTime notificationTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      20,
      0,
    );

    // If the current time is after 8pm, set the notification to next day
    if (DateTime.now().isAfter(notificationTime)) {
      notificationTime = notificationTime.add(Duration(days: 1));
    }
    flutterLocalNotificationsPlugin.zonedSchedule(
      NOTIFICATION_ID_8PM,
      'You haven\'t reached your daily goal yet',
      '4 hours left until the end of the day',
      tz.TZDateTime.from(notificationTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
            'channel id', 'channel name', 'channel description'),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  // This method is used to cancel the 8pm notification
  Future<void> cancelNotification() async {
    flutterLocalNotificationsPlugin.cancel(NOTIFICATION_ID_8PM);
  }
}

void initializeNotificationSettings() async {
  var initializationAndroid = AndroidInitializationSettings('flutter_logo');
  var initializationIOS = IOSInitializationSettings();

  var initializationSettings = InitializationSettings(
    android: initializationAndroid,
    iOS: initializationIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
