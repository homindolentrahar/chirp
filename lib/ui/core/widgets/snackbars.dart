import 'package:chirp/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

enum SnackbarType { ERROR, SUCCESS, GENERAL }

class Snackbars {
  static GetBar appSnackbar({
    Widget? icon,
    required String title,
    required String message,
    required SnackbarType type,
    ValueChanged<GetBar<Object>>? onTap,
  }) {
    final snackbarIcon = type == SnackbarType.SUCCESS
        ? Icon(
            Ionicons.checkmark_circle_outline,
            size: 24,
            color: Colors.green,
          )
        : type == SnackbarType.ERROR
            ? Icon(
                Ionicons.warning_outline,
                size: 24,
                color: Colors.red,
              )
            : icon;

    return GetBar(
      duration: 3.seconds,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      padding: const EdgeInsets.all(16),
      borderRadius: 2.5,
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      barBlur: 0.0,
      icon: snackbarIcon,
      forwardAnimationCurve: Curves.easeInQuint,
      reverseAnimationCurve: Curves.easeOutQuint,
      titleText: Text(
        title,
        style: Get.textTheme.headline4?.copyWith(color: AppColor.black),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      messageText: Text(
        message,
        style: Get.textTheme.bodyText2?.copyWith(
          color: AppColor.black.withOpacity(0.75),
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      backgroundColor: AppColor.white,
      onTap: onTap,
    );
  }
}