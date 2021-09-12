import 'package:chirp/controller/auth/auth_controller.dart';
import 'package:chirp/controller/auth/auth_states.dart';
import 'package:chirp/controller/profile/profile_controller.dart';
import 'package:chirp/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ChatsDrawer extends StatefulWidget {
  const ChatsDrawer({Key? key}) : super(key: key);

  @override
  _ChatsDrawerState createState() => _ChatsDrawerState();
}

class _ChatsDrawerState extends AuthState<ChatsDrawer>
    with SingleTickerProviderStateMixin {
  var expandHeader = false;

  @override
  Widget build(BuildContext context) {
    return GetX<ProfileController>(
      builder: (controller) => Container(
        width: Get.width * 0.75,
        padding: const EdgeInsets.symmetric(vertical: 12),
        color: Get.theme.canvasColor,
        child: Column(
          children: [
            ListTile(
              onTap: () {
                setState(() {
                  expandHeader = !expandHeader;
                });
              },
              leading: controller.profileUser.value.avatarUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(360),
                      child: Image.memory(
                        controller.getUserAvatar(),
                        width: 48,
                        height: 48,
                        cacheWidth: 48,
                        cacheHeight: 48,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
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
              title: Text(
                controller.profileUser.value.displayName,
                style: Get.textTheme.headline4,
              ),
              subtitle: Text(
                "@${controller.profileUser.value.username}",
                style: Get.textTheme.bodyText2,
              ),
              trailing: InkWell(
                splashColor: AppColor.white.withOpacity(0.15),
                highlightColor: AppColor.white.withOpacity(0.15),
                onTap: () {
                  setState(() {
                    expandHeader = !expandHeader;
                  });
                },
                child: Icon(
                  expandHeader ? Ionicons.chevron_up : Ionicons.chevron_down,
                  color: AppColor.white,
                ).paddingAll(8),
              ),
            ),
            AnimatedSize(
              vsync: this,
              duration: Duration(milliseconds: 500),
              reverseDuration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.dark,
                ),
                child: expandHeader
                    ? Column(
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            leading: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(360),
                                  child: Image.memory(
                                    controller.getUserAvatar(),
                                    width: 32,
                                    height: 32,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Get.theme.primaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Get.theme.canvasColor,
                                      width: 1.3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              "@${controller.profileUser.value.username}",
                              style: Get.textTheme.subtitle2,
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            leading: Icon(
                              Ionicons.add,
                              color: AppColor.white.withOpacity(0.75),
                            ),
                            title: Text(
                              "Add Account",
                              style: Get.textTheme.subtitle2?.copyWith(
                                color: AppColor.white.withOpacity(0.75),
                              ),
                            ),
                            onTap: () {},
                          ),
                          Divider(
                            color: AppColor.white.withOpacity(0.2),
                            indent: 24,
                            height: 0,
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            title: Text(
                              "Logout",
                              style: Get.textTheme.headline5?.copyWith(
                                color: Colors.red,
                              ),
                            ),
                            trailing: Icon(
                              Ionicons.log_out,
                              color: Colors.red,
                            ),
                            onTap: () {
                              Get.find<AuthController>().signOut().then(
                                    (_) => Get.offAllNamed("/landing"),
                                  );
                            },
                          ),
                        ],
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
