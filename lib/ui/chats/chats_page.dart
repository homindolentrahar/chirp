import 'package:chirp/controller/auth/auth_states.dart';
import 'package:chirp/controller/profile/profile_controller.dart';
import 'package:chirp/ui/chats/widgets/chats_drawer.dart';
import 'package:chirp/ui/core/widgets/buttons.dart';
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
          onPressed: () {
            Get.toNamed("/create-chats");
          },
          child: Icon(
            Ionicons.chatbubble,
            color: AppColor.black,
          ),
        ).marginAll(16),
        body: NestedScrollView(
          headerSliverBuilder: (ctx, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: AppIconButton(
                  icon: Ionicons.menu,
                  onPressed: () {
                    Scaffold.of(ctx).openDrawer();
                  },
                ),
                title: Text(
                  "Chats",
                  style: Get.textTheme.subtitle1,
                ),
                actions: [
                  AppIconButton(
                    icon: Ionicons.ellipsis_vertical,
                    iconSize: 20,
                    onPressed: () {},
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
