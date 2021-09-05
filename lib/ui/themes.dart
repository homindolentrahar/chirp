import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

class AppColor {
  static final Color black = "#141926".toColor();
  static final Color white = "#F8F8FF".toColor();
  static final Color primary = "#413DF7".toColor();
}

class AppThemes {
  static final ThemeData darkTheme = ThemeData(
    canvasColor: AppColor.black,
    primaryColor: AppColor.primary,
    fontFamily: 'SF',
    textTheme: TextTheme(
      headline2: TextStyle(
        color: AppColor.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        color: AppColor.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      subtitle2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyText2: TextStyle(
        color: AppColor.white.withOpacity(0.75),
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
