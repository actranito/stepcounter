import 'package:flutter/material.dart';
import 'package:stepcounter/constants/app_constants.dart';

/// This widget can display an Icon, followed by a main text, followed by a
/// subText, vertically. All the parameters are optional.
class GoalCounter extends StatelessWidget {
  final Widget? icon;
  final String? mainText;
  final String? subText;

  const GoalCounter({
    Key? key,
    this.icon,
    this.mainText,
    this.subText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Since the icon is optional we only display it when it's
        // not null
        if (this.icon != null)
          Column(
            children: [
              this.icon!,
              const SizedBox(height: 8.0),
            ],
          ),

        // Since the mainText is optional we only display it when it's
        // not null
        if (this.mainText != null)
          Column(
            children: [
              Text(
                this.mainText!,
                style: CustomTextStyles.BODY_BOLD,
              ),
              const SizedBox(height: 2.0),
            ],
          ),

        // Since the subText is optional we only display it when it's
        // not null
        if (this.subText != null)
          Text(
            this.subText!,
            style: CustomTextStyles.BODY,
          ),
      ],
    );
  }
}
