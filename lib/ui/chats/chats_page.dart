import 'package:chirp/controller/auth/auth_states.dart';
import 'package:chirp/controller/profile/profile_controller.dart';
import 'package:chirp/ui/chats/widgets/chats_drawer.dart';
import 'package:chirp/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends AuthRequiredState<ChatsPage> {
  @override
  void initState() {
    Get.find<ProfileController>().getProfileUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const ChatsDrawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.white,
          splashColor: AppColor.black.withOpacity(0.15),
          focusColor: AppColor.black.withOpacity(0.15),
          onPressed: () {},
          child: Icon(
            Ionicons.chatbubble,
            color: AppColor.black,
          ),
        ).marginAll(24),
        body: NestedScrollView(
          headerSliverBuilder: (ctx, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: InkWell(
                  borderRadius: BorderRadius.circular(360),
                  splashColor: AppColor.white.withOpacity(0.15),
                  highlightColor: AppColor.white.withOpacity(0.15),
                  onTap: () {
                    Scaffold.of(ctx).openDrawer();
                  },
                  child: Icon(
                    Ionicons.menu,
                    color: AppColor.white,
                  ).paddingAll(8),
                ),
                title: Text(
                  "Chats",
                  style: Get.textTheme.subtitle1,
                ),
                actions: [
                  InkWell(
                    borderRadius: BorderRadius.circular(360),
                    splashColor: AppColor.white.withOpacity(0.15),
                    highlightColor: AppColor.white.withOpacity(0.15),
                    onTap: () {},
                    child: Icon(
                      Ionicons.ellipsis_vertical,
                      color: AppColor.white,
                      size: 20,
                    ).paddingAll(8),
                  ),
                ],
                backgroundColor: Get.theme.canvasColor,
                elevation: 0,
                pinned: false,
                floating: true,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body: ListView(
            children: [],
          ),
        ),
      ),
    );
  }
}
