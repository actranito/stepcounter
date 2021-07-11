import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:stepcounter/constants/app_constants.dart';
import 'package:stepcounter/constants/enums.dart';
import 'dart:math' as math;

class CustomPercentIndicator extends StatelessWidget {
  final PercentIndicatorType
      percentIndicatorType; // This enum is used to define which type of percent indicator to display
  final double percent;

  const CustomPercentIndicator({
    Key? key,
    required this.percentIndicatorType,
    required this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the received percentage is valid (between 0.0 and 1.0)
    // If it's not a valid percentage, set it to the closest limit
    double finalPercentage = this.percent;
    if (finalPercentage < 0.0) {
      finalPercentage = 0.0;
    } else if (finalPercentage > 1.0) {
      finalPercentage = 1.0;
    }

    switch (this.percentIndicatorType) {
      case PercentIndicatorType.Circular:
        return this._displayCircularPercentIndicator(finalPercentage);

      case PercentIndicatorType.Linear:
        return this._displayLinearPercentIndicator(finalPercentage);

      default:
        // By default we will display a linear percent indicator
        return this._displayLinearPercentIndicator(finalPercentage);
    }
  }

  // This method is used to display a circular percentage indicator
  Widget _displayCircularPercentIndicator(double percentage) {
    return CircularPercentIndicator(
      radius: 180.0,
      lineWidth: 10.0,
      percent: percentage,
      circularStrokeCap: CircularStrokeCap.round,
      center: Text(
        // Multiply the finalPercetage by 100 to get the % to print
        '${(percentage * 100).toStringAsFixed(0)}%',
        style: CustomTextStyles.PERCENTAGE_TEXT,
      ),
      progressColor: AppColors.ORANGE,
      backgroundColor: AppColors.FADE_GRAY,
    );
  }

  // This method is used to display a linear percentage indicator
  // with a flag icon
  Widget _displayLinearPercentIndicator(double percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6.0,
            vertical: 2.0,
          ),
          child: Transform(
            // The Transform widget is used to get a symmetric icon
            // around the vertical axis
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Icon(
              Icons.flag,
              size: 18.0,
              color: AppColors.SOFT_BLUE,
            ),
          ),
        ),
        LinearPercentIndicator(
          alignment: MainAxisAlignment.center,
          lineHeight: 10.0,
          percent: 0.5,
          backgroundColor: AppColors.FADE_GRAY,
          progressColor: AppColors.ORANGE,
        ),
      ],
    );
  }
}
