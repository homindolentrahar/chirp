import 'dart:ui';
import 'package:flutter/material.dart';

class AppColor {
  static final Color black = Color(0xFF0E111A);
  static final Color dark = Color(0xFF141B26);
  static final Color white = Color(0xFFF8F8FF);
  static final Color primary = Color(0xFF413DF7);
  static final Color primaryText = Color(0xFF6864FD);
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
      headline5: TextStyle(
        color: AppColor.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      headline6: TextStyle(
        color: AppColor.white,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      subtitle1: TextStyle(
        color: AppColor.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      subtitle2: TextStyle(
        color: AppColor.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: TextStyle(
        color: AppColor.white.withOpacity(0.75),
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodyText2: TextStyle(
        color: AppColor.white.withOpacity(0.75),
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
