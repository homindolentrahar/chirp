import 'dart:developer';

import 'package:chirp/controller/profile/profile_controller.dart';
import 'package:chirp/data/auth/dtos/auth_user_dto.dart';
import 'package:get/get.dart';
import 'package:chirp/error/app_errors.dart';
import 'package:chirp/data/auth/auth_repository.dart';
import 'package:chirp/controller/core/base_controller.dart';

class AuthController extends BaseController {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  //  Sign Up observable password
  final signUpPassword = "".obs;

  Future<String> get currentUserId async {
    final currentUser = await _authRepository.getCurrentUser();
    return currentUser!.id;
  }

  Future<AuthUserDto> getCurrentUser() async {
    final currentUser = await _authRepository.getCurrentUser();
    final authUser = AuthUserDto.fromUser(currentUser);

    return authUser;
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

      final userProfileExists =
          await Get.find<ProfileController>().userExists();

      if (Get.isDialogOpen!) {
        Get.back();
      }

      if (userProfileExists) {
        Get.offAllNamed("/chats");
      } else {
        Get.offAllNamed("/auth-profile");
      }
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
      showProgressLoading();

      final session =
          await _authRepository.signUpWithEmailAndPassword(email, password);

      log("Logging in: ${session?.user?.email}");

      if (Get.isDialogOpen!) {
        Get.back();
      }

      Get.offAllNamed("/auth-profile");
    } on AuthError catch (e) {
      if (Get.isDialogOpen!) {
        Get.back();
      }

      showErrorSnackbar(error: e);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      showProgressLoading();

      await _authRepository.signInWithGoogle();

      final userProfileExists =
          await Get.find<ProfileController>().userExists();

      if (Get.isDialogOpen!) {
        Get.back();
      }

      if (userProfileExists) {
        Get.offAllNamed("/chats");
      } else {
        Get.offAllNamed("/auth-profile");
      }
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
