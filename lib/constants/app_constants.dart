import 'package:flutter/material.dart';

class AppColors {
  static const Color ORANGE = Color(0xFFF7A56C);
  static const Color FADE_GRAY = Color(0xFFEDF1F3);
  static const Color GRAY = Color(0xFFA6ACB4);
  static const Color SOFT_BLUE = Color(0xFF596274);
  static const Color DARK_BLUE = Color(0xFF1F3455);
}

class CustomIcons {
  static const String FLAME = 'assets/icons/flame.png';
  static const String STEPS = 'assets/icons/steps.png';
}

class CustomTextStyles {
  static const TextStyle TITLE = TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.w900,
    color: AppColors.DARK_BLUE,
    fontSize: 24.0,
  );

  static const TextStyle BODY = TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.normal,
    color: AppColors.SOFT_BLUE,
    fontSize: 14.0,
  );

  static const TextStyle BODY_BOLD = TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.bold,
    color: AppColors.SOFT_BLUE,
    fontSize: 14.0,
  );

  static const TextStyle PERCENTAGE_TEXT = TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.w800,
    color: AppColors.DARK_BLUE,
    fontSize: 50.0,
  );

  static const TextStyle BUTTON_TEXT = TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.bold,
    color: AppColors.GRAY,
    fontSize: 14.0,
  );

  static const TextStyle NUMBER_PICKER = TextStyle(
    fontFamily: 'Lato',
    color: AppColors.SOFT_BLUE,
    fontSize: 16.0,
  );

  static const TextStyle SNACKBAR = TextStyle(
    fontFamily: 'Lato',
    color: Colors.white,
    fontSize: 15.0,
  );
}
