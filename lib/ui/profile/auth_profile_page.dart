import 'dart:developer';
import 'dart:io';

import 'package:chirp/controller/auth/auth_states.dart';
import 'package:chirp/controller/profile/profile_controller.dart';
import 'package:chirp/ui/core/widgets/buttons.dart';
import 'package:chirp/ui/core/widgets/sheets.dart';
import 'package:chirp/ui/core/widgets/snackbars.dart';
import 'package:chirp/ui/core/widgets/textfields.dart';
import 'package:chirp/ui/profile/widgets/profile_tiles.dart';
import 'package:chirp/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class AuthProfilePage extends StatefulWidget {
  const AuthProfilePage({Key? key}) : super(key: key);

  @override
  _AuthProfilePageState createState() => _AuthProfilePageState();
}

class _AuthProfilePageState extends AuthRequiredState<AuthProfilePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  late TextEditingController _usernameController;
  late TextEditingController _displayNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _bioController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _displayNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _bioController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetX<ProfileController>(
        init: Get.find<ProfileController>(),
        builder: (controller) => Scaffold(
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            focusElevation: 0,
            backgroundColor: AppColor.white,
            child: Icon(
              Ionicons.cloud_upload,
              color: AppColor.black,
            ),
            onPressed: () async {
              //  Save then proceed to /chats
              _formKey.currentState?.save();

              if (_formKey.currentState!.validate() &&
                  controller.username.value.isNotEmpty &&
                  controller.phoneNumber.value.isNotEmpty &&
                  controller.bio.value.isNotEmpty) {
                await controller.addProfileUser();
              } else {
                Get.showSnackbar(
                  Snackbars.appSnackbar(
                    title: "Invalid field values",
                    message: "Please input valid value in the fields",
                    type: SnackbarType.ERROR,
                  ),
                );
              }
            },
          ).paddingSymmetric(horizontal: 24, vertical: 48),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Profile",
                        style: Get.textTheme.headline4,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: ProceedButton(
                          filled: false,
                          onPressed: () async {
                            Get.dialog(
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                backgroundColor: Get.theme.canvasColor,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Skip Profile?",
                                      style: Get.textTheme.headline4,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "You can fill your profile later in the settings page",
                                      style: Get.textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: Text(
                                      "Cancel",
                                      style: Get.textTheme.bodyText2?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.find<ProfileController>()
                                          .addInitialProfileUser();
                                    },
                                    child: Text(
                                      "Skip",
                                      style: Get.textTheme.bodyText2?.copyWith(
                                        color: Get.theme.primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ).paddingOnly(top: 24, right: 24, left: 24),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          controller.avatarUrl.startsWith(
                            "/data/user/0/com.homindolentrahar.chirp",
                          )
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(360),
                                  child: Hero(
                                    tag: "euy",
                                    child: Image.file(
                                      File(controller.avatarUrl.value),
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1.5,
                                      color: AppColor.white.withOpacity(0.5),
                                    ),
                                  ),
                                  child: Icon(
                                    Ionicons.person_outline,
                                    color: AppColor.white.withOpacity(0.75),
                                  ),
                                ),
                          Positioned(
                            right: -8,
                            bottom: -8,
                            child: MaterialButton(
                              elevation: 0,
                              highlightElevation: 0,
                              minWidth: 0,
                              height: 0,
                              padding: const EdgeInsets.all(8),
                              shape: CircleBorder(
                                side: BorderSide(
                                  color: AppColor.black,
                                  width: 2.5,
                                ),
                              ),
                              color: Get.theme.primaryColor,
                              splashColor: AppColor.black.withOpacity(0.5),
                              focusColor: AppColor.black.withOpacity(0.75),
                              child: Icon(
                                Ionicons.camera,
                                color: AppColor.white,
                                size: 16,
                              ),
                              onPressed: () {
                                //  show bottom sheet picker
                                Get.bottomSheet(
                                  ImagePickerSheet(
                                    pickImage: () async {
                                      final image =
                                          await controller.pickImage();

                                      log(image?.path.toString() ?? "No Path");

                                      controller.avatarUrl.value =
                                          image?.path ??
                                              controller.avatarUrl.value;
                                    },
                                    capturePhoto: () async {
                                      final image =
                                          await controller.capturePhoto();

                                      log(image?.path.toString() ?? "No Path");

                                      controller.avatarUrl.value =
                                          image?.path ??
                                              controller.avatarUrl.value;
                                    },
                                    removePhoto: () {
                                      controller.avatarUrl.value = "";
                                    },
                                  ),
                                  isScrollControlled: true,
                                  backgroundColor: AppColor.black,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppTextField(
                          controller: _displayNameController,
                          type: AppTextFieldType.UNDERLINE,
                          name: "displayName",
                          hintText: "Display Name",
                          validators: FormBuilderValidators.required(context),
                          onChanged: (value) {
                            if (value!.isNotEmpty) {
                              log("Changed: $value");
                            }

                            controller.displayName.value = value;
                          },
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 24),
                  const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Account",
                        style: Get.textTheme.subtitle2?.copyWith(
                          color: AppColor.primaryText,
                        ),
                      ).marginOnly(left: 24),
                      const SizedBox(height: 8),
                      Column(
                        children: [
                          AccountProfileTiles(
                            title: controller.username.value.isEmpty
                                ? "Empty Username"
                                : controller.username.value,
                            subtitle: "Username",
                            onTap: () {
                              Get.bottomSheet(
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Username",
                                          style: Get.textTheme.headline4,
                                        ),
                                        InkWell(
                                          splashColor:
                                              AppColor.white.withOpacity(0.05),
                                          highlightColor:
                                              AppColor.white.withOpacity(0.05),
                                          focusColor:
                                              AppColor.white.withOpacity(0.05),
                                          borderRadius:
                                              BorderRadius.circular(360),
                                          onTap: () {
                                            if (_usernameController
                                                .text.isEmpty) {
                                              return;
                                            }

                                            controller.username.value =
                                                _usernameController.text;

                                            Get.back();
                                          },
                                          child: Icon(
                                            Ionicons.checkmark,
                                            color: AppColor.white,
                                          ).paddingAll(8),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    AppTextField(
                                      controller: _usernameController
                                        ..text = controller.username.value,
                                      autofocus: true,
                                      type: AppTextFieldType.UNDERLINE,
                                      name: "username",
                                      prefixText: "@",
                                      hintText: "awesome_name67",
                                      validators:
                                          FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                        FormBuilderValidators.minLength(
                                            context, 8),
                                      ]),
                                      onChanged: (value) {},
                                    ),
                                  ],
                                ).paddingAll(24),
                                isScrollControlled: true,
                                backgroundColor: AppColor.black,
                              );
                            },
                          ),
                          AccountProfileTiles(
                            title: controller.phoneNumber.value.isEmpty
                                ? "Empty Phone"
                                : controller.phoneNumber.value,
                            subtitle: "Phone Number",
                            onTap: () {
                              Get.bottomSheet(
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Phone Number",
                                          style: Get.textTheme.headline4,
                                        ),
                                        InkWell(
                                          splashColor:
                                              AppColor.white.withOpacity(0.05),
                                          highlightColor:
                                              AppColor.white.withOpacity(0.05),
                                          focusColor:
                                              AppColor.white.withOpacity(0.05),
                                          borderRadius:
                                              BorderRadius.circular(360),
                                          onTap: () {
                                            if (_phoneNumberController
                                                .text.isEmpty) {
                                              return;
                                            }

                                            controller.phoneNumber.value =
                                                _phoneNumberController.text;

                                            Get.back();
                                          },
                                          child: Icon(
                                            Ionicons.checkmark,
                                            color: AppColor.white,
                                          ).paddingAll(8),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    AppTextField(
                                      controller: _phoneNumberController
                                        ..text = controller.phoneNumber.value,
                                      autofocus: true,
                                      type: AppTextFieldType.UNDERLINE,
                                      keyboardType: TextInputType.phone,
                                      name: "phoneNumber",
                                      hintText: "022-345-786",
                                      validators:
                                          FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                        FormBuilderValidators.maxLength(
                                          context,
                                          13,
                                        ),
                                        FormBuilderValidators.minLength(
                                          context,
                                          10,
                                        ),
                                      ]),
                                      onChanged: (value) {},
                                    ),
                                  ],
                                ).paddingAll(24),
                                isScrollControlled: true,
                                backgroundColor: AppColor.black,
                              );
                            },
                          ),
                          AccountProfileTiles(
                            title: controller.bio.value.isEmpty
                                ? "Empty Bio"
                                : controller.bio.value,
                            subtitle: "Bio",
                            onTap: () {
                              Get.bottomSheet(
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Bio",
                                          style: Get.textTheme.headline4,
                                        ),
                                        InkWell(
                                          splashColor:
                                              AppColor.white.withOpacity(0.05),
                                          highlightColor:
                                              AppColor.white.withOpacity(0.05),
                                          focusColor:
                                              AppColor.white.withOpacity(0.05),
                                          borderRadius:
                                              BorderRadius.circular(360),
                                          onTap: () {
                                            if (_bioController.text.isEmpty) {
                                              return;
                                            }

                                            controller.bio.value =
                                                _bioController.text;

                                            Get.back();
                                          },
                                          child: Icon(
                                            Ionicons.checkmark,
                                            color: AppColor.white,
                                          ).paddingAll(8),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    AppTextField(
                                      controller: _bioController
                                        ..text = controller.bio.value,
                                      autofocus: true,
                                      type: AppTextFieldType.UNDERLINE,
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      name: "bio",
                                      hintText: "Describe yourself",
                                      validators:
                                          FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                        FormBuilderValidators.maxLength(
                                          context,
                                          75,
                                        ),
                                      ]),
                                      onChanged: (value) {},
                                    ),
                                  ],
                                ).paddingAll(24),
                                isScrollControlled: true,
                                backgroundColor: AppColor.black,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
