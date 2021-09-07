import 'package:chirp/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class FilledButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const FilledButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      highlightElevation: 0,
      focusElevation: 0,
      disabledElevation: 0,
      minWidth: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.5)),
      color: backgroundColor,
      splashColor: AppColor.black.withOpacity(0.15),
      highlightColor: AppColor.black.withOpacity(0.25),
      child: Text(
        text,
        style: Get.textTheme.headline4?.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
    );
  }
}

class BorderedButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const BorderedButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      elevation: 0,
      highlightElevation: 0,
      focusElevation: 0,
      disabledElevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.5),
        side: BorderSide(color: color, width: 1.5),
      ),
      color: Colors.transparent,
      splashColor: AppColor.white.withOpacity(0.15),
      highlightColor: AppColor.white.withOpacity(0.25),
      child: Text(
        text,
        style: Get.textTheme.headline4?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
    );
  }
}

class AppBackButton extends StatelessWidget {
  const AppBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      highlightElevation: 0,
      focusElevation: 0,
      disabledElevation: 0,
      minWidth: 0,
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
      color: AppColor.white,
      splashColor: AppColor.black.withOpacity(0.15),
      highlightColor: AppColor.black.withOpacity(0.25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.5)),
      child: Icon(
        Ionicons.arrow_back,
        color: AppColor.black,
        size: 16,
      ),
      onPressed: () => Get.back(),
    );
  }
}
