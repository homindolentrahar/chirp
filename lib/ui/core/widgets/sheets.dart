import 'package:chirp/ui/themes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ImagePickerSheet extends StatelessWidget {
  final VoidCallback pickImage;
  final VoidCallback capturePhoto;
  final VoidCallback removePhoto;

  const ImagePickerSheet({
    Key? key,
    required this.pickImage,
    required this.capturePhoto,
    required this.removePhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Profile Photo",
          style: Get.textTheme.headline4,
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                pickImage();
                Get.back();
              },
              child: Column(
                children: [
                  Icon(
                    Ionicons.image,
                    color: AppColor.white,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Gallery",
                    style: Get.textTheme.bodyText2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 40),
            GestureDetector(
              onTap: () {
                capturePhoto();
                Get.back();
              },
              child: Column(
                children: [
                  Icon(
                    Ionicons.camera,
                    color: AppColor.white,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Camera",
                    style: Get.textTheme.bodyText2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 40),
            GestureDetector(
              onTap: () {
                removePhoto();
                Get.back();
              },
              child: Column(
                children: [
                  Icon(
                    Ionicons.trash,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Remove",
                    style: Get.textTheme.bodyText2?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ).paddingAll(24);
  }
}
