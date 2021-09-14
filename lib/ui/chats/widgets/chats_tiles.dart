import 'dart:typed_data';
import 'dart:ui';

import 'package:chirp/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateChatsTile extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final String text;
  final VoidCallback onTap;

  const CreateChatsTile({
    Key? key,
    required this.icon,
    this.iconSize = 20,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: AppColor.white.withOpacity(0.05),
      highlightColor: AppColor.white.withOpacity(0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: AppColor.white.withOpacity(0.75),
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: Get.textTheme.subtitle2,
          ),
        ],
      ).paddingAll(20),
    );
  }
}

class ContactTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Uint8List imageMemorySrc;
  final VoidCallback onTap;

  const ContactTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageMemorySrc,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColor.white.withOpacity(0.05),
      highlightColor: AppColor.white.withOpacity(0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(360),
            child: Image.memory(
              imageMemorySrc,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Get.textTheme.subtitle2,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Get.textTheme.bodyText2,
              ),
            ],
          ),
        ],
      ).paddingAll(12),
    );
  }
}
