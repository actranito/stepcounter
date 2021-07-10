import 'package:flutter/material.dart';
import 'package:stepcounter/constants/app_constants.dart';
import 'package:stepcounter/constants/enums.dart';
import 'package:stepcounter/widgets/custom_percent_indicator.dart';
import 'package:stepcounter/widgets/custom_rounded_button.dart';
import 'package:stepcounter/widgets/goal_counter.dart';

class TestView extends StatelessWidget {
  const TestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                IconButton(
                  onPressed: () {
                    print('Togle notifications');
                  },
                  icon: Icon(
                    Icons.notifications_off_outlined,
                    color: AppColors.DARK_BLUE,
                    size: 26.0,
                  ),
                )
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
              percent: 0.49,
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
                  mainText: '1557 / 3000',
                  subText: 'Schritte',
                ),
                GoalCounter(
                  icon: ImageIcon(
                    AssetImage(CustomIcons.FLAME),
                    color: AppColors.ORANGE,
                  ),
                  mainText: '340',
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
                print('Daily Goal pressed');
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: CustomPercentIndicator(
                percent: 0.49,
                percentIndicatorType: PercentIndicatorType.Linear,
              ),
            ),
          ],
        ));
  }
}
