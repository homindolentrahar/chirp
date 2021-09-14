import 'package:chirp/controller/auth/auth_states.dart';
import 'package:chirp/controller/chats/chats_controller.dart';
import 'package:chirp/ui/chats/widgets/chats_tiles.dart';
import 'package:chirp/ui/core/widgets/buttons.dart';
import 'package:chirp/ui/themes.dart';
import 'package:chirp/utils/value_formatters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CreateChatsPage extends StatefulWidget {
  const CreateChatsPage({Key? key}) : super(key: key);

  @override
  _CreateChatsPageState createState() => _CreateChatsPageState();
}

class _CreateChatsPageState extends AuthRequiredState<CreateChatsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetX<ChatsController>(
        init: Get.find<ChatsController>()..getContacts(),
        builder: (controller) => Scaffold(
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            backgroundColor: AppColor.white,
            child: Icon(
              Ionicons.person_add,
              color: AppColor.black,
            ),
            onPressed: () {},
          ).marginAll(16),
          body: Column(
            children: [
              Row(
                children: [
                  const AppBackButton(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Organism",
                          style: Get.textTheme.subtitle1,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${controller.contactsData.length} orgs",
                          style: Get.textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  AppIconButton(
                    icon: Ionicons.search_outline,
                    iconSize: 20,
                    onPressed: () {},
                  ),
                  AppIconButton(
                    icon: Ionicons.ellipsis_vertical,
                    iconSize: 20,
                    onPressed: () {},
                  ),
                ],
              ).paddingAll(12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CreateChatsTile(
                      icon: Ionicons.people_circle_outline,
                      text: "New Circle",
                      onTap: () {},
                    ),
                    CreateChatsTile(
                      icon: Ionicons.paw_outline,
                      text: "New Flock",
                      onTap: () {},
                    ),
                    Divider(
                      color: AppColor.white.withOpacity(0.10),
                      height: 0,
                      thickness: 1,
                      indent: 24,
                      endIndent: 24,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Organism",
                      style: Get.textTheme.headline6?.copyWith(
                        color: AppColor.primaryText,
                      ),
                    ).marginOnly(left: 12, top: 12),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.contactsData.length,
                        itemBuilder: (ctx, index) {
                          final dto = controller.contactsData[index];

                          return ContactTile(
                            title: "@${dto.username}",
                            subtitle: dto.displayName,
                            imageMemorySrc:
                                ValueFormatters.parseImageData(dto.avatarUrl),
                            onTap: () {
                              controller.createRoom(dto);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
