import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:stepcounter/blocs/settings_bloc/settings_bloc.dart';
import 'package:stepcounter/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepcounter/widgets/custom_rounded_button.dart';

class SetDailyGoalView extends StatefulWidget {
  final BuildContext context;
  final int initialValue;

  const SetDailyGoalView({
    Key? key,
    required this.context,
    this.initialValue = 0,
  }) : super(key: key);

  @override
  _SetDailyGoalViewState createState() => _SetDailyGoalViewState();
}

class _SetDailyGoalViewState extends State<SetDailyGoalView> {
  late int selectedValue;

  @override
  void initState() {
    this.selectedValue = this.widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Text(
                  'Daily Goal',
                  style: CustomTextStyles.TITLE,
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Steps',
                  style: CustomTextStyles.BODY_BOLD.copyWith(fontSize: 20.0),
                ),
                const SizedBox(height: 15.0),
                NumberPicker(
                  itemHeight: 40.0,
                  step: 100,
                  minValue: 1000,
                  maxValue: 100000,
                  itemCount: 5,
                  selectedTextStyle: CustomTextStyles.NUMBER_PICKER.copyWith(
                    color: AppColors.ORANGE,
                    fontSize: 26.0,
                  ),
                  textStyle: CustomTextStyles.NUMBER_PICKER,
                  value: this.selectedValue,
                  onChanged: (int value) {
                    this.setState(() {
                      this.selectedValue = value;
                    });
                  },
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: CustomRoundedButton(
                text: 'Set',
                color: AppColors.ORANGE,
                textColor: Colors.white,
                onTap: () {
                  (this.widget.context)
                      .read<SettingsBloc>()
                      .add(SetDailyGoalEvent(dailyGoal: this.selectedValue));
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
