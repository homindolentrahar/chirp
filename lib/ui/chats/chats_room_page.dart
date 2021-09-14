import 'package:chirp/controller/auth/auth_states.dart';
import 'package:chirp/controller/chats/chats_controller.dart';
import 'package:chirp/data/profile/dtos/profile_user_dto.dart';
import 'package:chirp/ui/core/widgets/buttons.dart';
import 'package:chirp/utils/value_formatters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ChatsRoomPage extends StatefulWidget {
  const ChatsRoomPage({Key? key}) : super(key: key);

  @override
  _ChatsRoomPageState createState() => _ChatsRoomPageState();
}

class _ChatsRoomPageState extends AuthRequiredState<ChatsRoomPage> {
  @override
  Widget build(BuildContext context) {
    final data = Get.arguments as Map<String, ProfileUserDto>;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppIconButton(
                  icon: Ionicons.arrow_back,
                  iconSize: 20,
                  onPressed: () {
                    Get.back();
                  },
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(360),
                        child: Image.memory(
                          ValueFormatters.parseImageData(
                            data['profile']!.avatarUrl,
                          ),
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        data['profile']!.displayName,
                        style: Get.textTheme.subtitle2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                AppIconButton(
                  icon: Ionicons.ellipsis_vertical,
                  iconSize: 20,
                  onPressed: () {},
                ),
              ],
            ).paddingAll(12),
            Expanded(
              child: GetX<ChatsController>(
                init: Get.find<ChatsController>()..listeningRoomInfo(),
                builder: (controller) {
                  return Center(
                    child: controller.roomInfo.value.isEmpty
                        ? Text(
                            "No Info Available",
                            style: Get.textTheme.bodyText2,
                          )
                        : Text(
                            controller.roomInfo.value,
                            style: Get.textTheme.subtitle2,
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
