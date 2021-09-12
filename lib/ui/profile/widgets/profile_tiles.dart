import 'package:get/get.dart';
import 'package:chirp/ui/themes.dart';
import 'package:flutter/material.dart';

class AccountProfileTiles extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const AccountProfileTiles({
    Key? key,
    required this.onTap,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColor.white.withOpacity(0.05),
      highlightColor: AppColor.white.withOpacity(0.05),
      focusColor: AppColor.white.withOpacity(0.05),
      child: Column(
        children: [
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Get.textTheme.subtitle1,
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: Get.textTheme.bodyText2?.copyWith(
                    color: AppColor.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: AppColor.white.withOpacity(0.2),
            indent: 24,
            endIndent: 24,
            height: 0,
          ),
        ],
      ),
    );
  }
}
