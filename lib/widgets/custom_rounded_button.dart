import 'package:flutter/material.dart';
import 'package:stepcounter/constants/app_constants.dart';

/// This widget displays a rounded button.
/// It is required to pass the onTap callback function.
class CustomRoundedButton extends StatelessWidget {
  final Widget? icon;
  final String? text;
  final Function onTap;
  final Color color;
  final Color? textColor;
  const CustomRoundedButton({
    Key? key,
    required this.onTap,
    this.icon,
    this.text,
    this.color = AppColors.FADE_GRAY,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: () => this.onTap(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // If icon not null show icon
            if (this.icon != null)
              Row(
                children: [
                  this.icon!,
                  const SizedBox(width: 4.0),
                ],
              ),
            if (this.text != null)
              Text(
                this.text!,
                style: (this.textColor == null)
                    ? CustomTextStyles.BUTTON_TEXT
                    : CustomTextStyles.BUTTON_TEXT.copyWith(
                        color: textColor,
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
