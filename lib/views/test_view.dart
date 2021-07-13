import 'package:flutter/material.dart';
import 'package:stepcounter/blocs/settings_bloc/settings_bloc.dart';
import 'package:stepcounter/blocs/stepcounter_bloc/stepcounter_bloc.dart';
import 'package:stepcounter/constants/app_constants.dart';
import 'package:stepcounter/constants/enums.dart';
import 'package:stepcounter/widgets/custom_percent_indicator.dart';
import 'package:stepcounter/widgets/custom_rounded_button.dart';
import 'package:stepcounter/widgets/goal_counter.dart';
import 'package:stepcounter/widgets/toggle_notifications_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestView extends StatelessWidget {
  const TestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Builder(builder: (context) {
          StepcounterState stepcounterState =
              (context).watch<StepcounterBloc>().state;

          if (stepcounterState is StepcounterLoaded) {
            // Watch for changes in the dailyGoal value
            int dailyGoal = (context).watch<SettingsBloc>().state.dailyGoal;
            int steps = stepcounterState.stepcounterData.steps;
            int calories = stepcounterState.stepcounterData.calories;
            double percent = steps.toDouble() / dailyGoal;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      ToggleNotificationsButton(),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Stepcounter',
                        style: CustomTextStyles.TITLE,
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                  CustomPercentIndicator(
                    percent: percent,
                    percentIndicatorType: PercentIndicatorType.Circular,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GoalCounter(
                        icon: ImageIcon(
                          AssetImage(CustomIcons.STEPS),
                          color: AppColors.ORANGE,
                        ),
                        mainText: '$steps / $dailyGoal',
                        subText: 'Schritte',
                      ),
                      GoalCounter(
                        icon: ImageIcon(
                          AssetImage(CustomIcons.FLAME),
                          color: AppColors.ORANGE,
                        ),
                        mainText: '$calories',
                        subText: 'Kalorien',
                      ),
                    ],
                  ),
                  CustomRoundedButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      color: AppColors.GRAY,
                      size: 16.0,
                    ),
                    text: 'Daily Goal',
                    onTap: () {
                      (context)
                          .read<SettingsBloc>()
                          .add(SetDailyGoalEvent(dailyGoal: dailyGoal + 100));
                      print('Daily Goal pressed');
                    },
                  ),
                  CustomPercentIndicator(
                    percent: percent,
                    percentIndicatorType: PercentIndicatorType.Linear,
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('Loading...'),
            );
          }
        }),
      ),
    );
  }
}
