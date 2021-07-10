import 'package:flutter/material.dart';
import 'package:stepcounter/constants/app_constants.dart';

class CustomRoundedButton extends StatelessWidget {
  final Widget? icon;
  final String? text;
  final Function onTap;
  const CustomRoundedButton({
    Key? key,
    this.icon,
    this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: AppColors.FADE_GRAY,
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
                style: CustomTextStyles.BUTTON_TEXT,
              ),
          ],
        ),
      ),
    );
  }
}
