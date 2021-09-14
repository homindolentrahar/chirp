import 'dart:developer';
import 'dart:typed_data';

import 'package:chirp/controller/auth/auth_controller.dart';
import 'package:chirp/controller/core/base_controller.dart';
import 'package:chirp/data/profile/dtos/profile_user_dto.dart';
import 'package:chirp/data/profile/profile_repository.dart';
import 'package:chirp/error/app_errors.dart';
import 'package:chirp/utils/value_formatters.dart';
import 'package:get/get.dart';

class ProfileController extends BaseController {
  final ProfileRepository _profileRepository;

  ProfileController({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  final Rx<ProfileUserDto> profileUser = ProfileUserDto().obs;

  //  Editable data
  final username = "".obs;
  final email = "".obs;
  final phoneNumber = "".obs;
  final avatarUrl = "".obs;
  final displayName = "".obs;
  final bio = "".obs;

  void resetEditableData() {
    username.value = "";
    email.value = "";
    phoneNumber.value = "";
    avatarUrl.value = "";
    displayName.value = "";
    bio.value = "";
  }

  Uint8List getUserAvatar() {
    return ValueFormatters.parseImageData(profileUser.value.avatarUrl);
  }

  Future<bool> userExists() async {
    try {
      final userId = await Get.find<AuthController>().currentUserId;

      return await _profileRepository.userExists(userId);
    } on AppError catch (e) {
      log(e.message);
      return false;
    }
  }

  Future<void> getProfileUser() async {
    try {
      final userId = await Get.find<AuthController>().currentUserId;
      final result = await _profileRepository.getProfileUser(userId);

      log("Username: ${result.username}\nUser ID: ${result.userId}");

      profileUser.value = result;
    } on AppError catch (e) {
      log(e.message);
    }
  }

  Future<void> addInitialProfileUser() async {
    try {
      showProgressLoading();

      final currentUser = await Get.find<AuthController>().getCurrentUser();
      final dto = ProfileUserDto(
        userId: currentUser.userId,
        username: currentUser.email,
        email: currentUser.email,
        phoneNumber: "Empty Phone",
        avatarUrl: "",
        displayName: currentUser.email,
        bio: "Hi, I\'m new here",
        createdAt: currentUser.createdAt,
        lastSignInAt: currentUser.lastSignAt,
      );

      await _profileRepository.addProfileUser(dto);

      log("Success adding user");

      if (Get.isDialogOpen!) {
        Get.back();
      }

      Get.offAllNamed("/chats");
    } on AppError catch (e) {
      log(e.message);

      if (Get.isDialogOpen!) {
        Get.back();
      }

      Get.offAllNamed("/chats");
    }
  }

  Future<void> addProfileUser() async {
    try {
      showProgressLoading();

      final currentUser = await Get.find<AuthController>().getCurrentUser();
      final user = ProfileUserDto(
        userId: currentUser.userId,
        username: username.value,
        email: currentUser.email,
        phoneNumber: phoneNumber.value,
        avatarUrl: avatarUrl.value,
        displayName: displayName.value,
        bio: bio.value,
        createdAt: currentUser.createdAt,
        lastSignInAt: currentUser.lastSignAt,
      );

      await _profileRepository.addProfileUser(user);

      log("Success adding user");

      if (Get.isDialogOpen!) {
        Get.back();
      }

      Get.offAllNamed("/chats");
    } on AppError catch (e) {
      log(e.message);

      if (Get.isDialogOpen!) {
        Get.back();
      }

      showErrorSnackbar(error: e);
    }
  }
}
