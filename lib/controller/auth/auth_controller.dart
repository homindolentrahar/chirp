import 'dart:developer';

import 'package:get/get.dart';
import 'package:chirp/error/app_errors.dart';
import 'package:chirp/data/auth_repository.dart';
import 'package:chirp/controller/core/base_controller.dart';
import 'package:supabase/supabase.dart';

class AuthController extends BaseController {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  final validateForm = false.obs;

  void resetObservables() {
    validateForm.value = false;
  }

  Future<User> getCurrentUser() async {
    final currentUser = await _authRepository.getCurrentUser();

    log(currentUser!.id);

    return currentUser;
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      showProgressLoading();

      final session =
          await _authRepository.signInWithEmailAndPassword(email, password);

      log("Logging in: ${session?.user?.email}");

      if (Get.isDialogOpen!) {
        Get.back();
      }
      Get.offAllNamed("/main");
    } on AuthError catch (e) {
      if (Get.isDialogOpen!) {
        Get.back();
      }

      showErrorSnackbar(error: e);
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      validateForm.value = true;
      showProgressLoading();

      final session =
          await _authRepository.signUpWithEmailAndPassword(email, password);

      log("Logging in: ${session?.user?.email}");

      if (Get.isDialogOpen!) {
        Get.back();
      }
      Get.offAllNamed("/main");
    } on AuthError catch (e) {
      if (Get.isDialogOpen!) {
        Get.back();
      }

      showErrorSnackbar(error: e);
    }
  }

  Future<void> signOut() async {
    showProgressLoading();

    await _authRepository.signOut();
  }
}
