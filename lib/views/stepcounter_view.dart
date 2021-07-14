import 'package:flutter/material.dart';
import 'package:stepcounter/blocs/settings_bloc/settings_bloc.dart';
import 'package:stepcounter/blocs/stepcounter_bloc/stepcounter_bloc.dart';
import 'package:stepcounter/constants/app_constants.dart';
import 'package:stepcounter/constants/enums.dart';
import 'package:stepcounter/models/stepcounter_data.dart';
import 'package:stepcounter/views/set_daily_goal_view.dart';
import 'package:stepcounter/widgets/custom_percent_indicator.dart';
import 'package:stepcounter/widgets/custom_rounded_button.dart';
import 'package:stepcounter/widgets/goal_counter.dart';
import 'package:stepcounter/widgets/toggle_notifications_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This view is used to load and show the stepcounter information
class StepcounterView extends StatelessWidget {
  const StepcounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Add safe on the vertical margins only
      body: SafeArea(
        left: false,
        right: false,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              this._displayAppBar(),
              Expanded(
                child: Builder(builder: (context) {
                  // Handle with state changes on the Stepcounter bloc here

                  // Watch for changes in the StepcounterBloc
                  StepcounterState stepcounterState =
                      (context).watch<StepcounterBloc>().state;

                  // if stepcounterState is Loading show loading
                  // progress indicator
                  if (stepcounterState is StepcounterLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.ORANGE,
                      ),
                    );

                    // if stepcounterState is Loaded show info
                  } else if (stepcounterState is StepcounterLoaded) {
                    // Watch for changes in the dailyGoal varible
                    int dailyGoal =
                        (context).watch<SettingsBloc>().state.dailyGoal;

                    // Get the stepcounterData from the state
                    StepcounterData stepcounterData =
                        stepcounterState.stepcounterData;
                    return this._displayInfo(
                      context: context,
                      stepcounterData: stepcounterData,
                      dailyGoal: dailyGoal,
                    );
                  }

                  // if stepcounterState is Error show error
                  else if (stepcounterState is StepcounterError) {
                    return Center(
                      child: Text('Error'),
                    );

                    // any other state show error message
                  } else {
                    return Center(
                      child: Text('Error - Unknown state'),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// This method is used to display the appBar of this view
  Widget _displayAppBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.arrow_back_ios,
              color: AppColors.DARK_BLUE,
            ),
            ToggleNotificationsButton(),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          // A row with an expanded container is used here
          // to push the title to the left
          children: [
            Text(
              'Stepcounter',
              style: CustomTextStyles.TITLE,
            ),
            Expanded(child: Container()),
          ],
        ),
      ],
    );
  }

  /// This method is used to display the steps and calories info
  Widget _displayInfo({
    required BuildContext context,
    required StepcounterData stepcounterData,
    required int dailyGoal,
  }) {
    // Calculate the percetage of the daily steps in relation to the dailyGoal
    double percent = stepcounterData.steps.toDouble() / dailyGoal;

    return Column(
      // There are two expanded empty Containers at the top and bottom of the
      // Column. Their pusrpose is to display the info in the correct place.
      // By setting the flex to 1 on the top Container and flex to 3 on the
      // bottom container we are setting the info in the center top part of the
      // screen with 1/3 of the space in the top and 2/3 of the space in the
      // bottom
      children: [
        Expanded(
          child: Container(),
          flex: 1,
        ),
        CustomPercentIndicator(
          percentIndicatorType: PercentIndicatorType.Circular,
          percent: percent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GoalCounter(
              icon: ImageIcon(
                AssetImage(CustomIcons.STEPS),
                color: AppColors.ORANGE,
              ),
              mainText: '${stepcounterData.steps} / $dailyGoal',
              subText: 'Steps',
            ),
            GoalCounter(
              icon: ImageIcon(
                AssetImage(CustomIcons.FLAME),
                color: AppColors.ORANGE,
              ),
              mainText: '${stepcounterData.calories}',
              subText: 'Calories',
            ),
          ],
        ),
        const SizedBox(height: 25.0),
        CustomRoundedButton(
          icon: Icon(
            Icons.edit_outlined,
            color: AppColors.GRAY,
            size: 16.0,
          ),
          text: 'Daily Goal',
          onTap: () async {
            // On pressed open a modalBottomSheet to select the dailyGoal
            await showModalBottomSheet(
                context: context,
                builder: (_) {
                  // Get the current dailyGoal value to pass it to the
                  // SetDailyGoalView
                  int currentDailyGoal =
                      (context).read<SettingsBloc>().state.dailyGoal;
                  return SetDailyGoalView(
                    context: context,
                    initialValue: currentDailyGoal,
                  );
                });
          },
        ),
        const SizedBox(height: 30.0),
        CustomPercentIndicator(
          percent: percent,
          percentIndicatorType: PercentIndicatorType.Linear,
        ),
        Expanded(
          child: Container(),
          flex: 3,
        ),
      ],
    );
  }
}
