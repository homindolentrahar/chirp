import 'package:chirp/error/app_errors.dart';
import 'package:chirp/ui/core/widgets/snackbars.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class BaseController extends GetxController {
  void showProgressLoading() {
    Get.dialog(
      SizedBox(
        width: 48,
        height: 48,
        child: Lottie.asset(
          "assets/lotties/loading.json",
          width: 48,
          height: 48,
          repeat: true,
          frameRate: FrameRate(60),
        ),
      ),
    );
  }

  void showErrorSnackbar({
    required AppError error,
    ValueChanged<GetBar<Object>>? onTap,
  }) {
    Get.showSnackbar(
      Snackbars.appSnackbar(
          title: error.toString().substring(0, error.toString().indexOf(":")),
          message: error.message,
          type: SnackbarType.ERROR,
          onTap: onTap),
    );
  }

  void showSuccessSnackbar({
    required String title,
    required String message,
    ValueChanged<GetBar<Object>>? onTap,
  }) {
    Get.showSnackbar(
      Snackbars.appSnackbar(
        title: title,
        message: message,
        type: SnackbarType.ERROR,
        onTap: onTap,
      ),
    );
  }
}
