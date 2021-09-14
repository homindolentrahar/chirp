import 'package:chirp/controller/auth/auth_controller.dart';
import 'package:chirp/controller/core/base_controller.dart';
import 'package:chirp/controller/profile/profile_controller.dart';
import 'package:chirp/data/chats/chats_repository.dart';
import 'package:chirp/data/profile/dtos/profile_user_dto.dart';
import 'package:chirp/error/app_errors.dart';
import 'package:get/get.dart';

class ChatsController extends BaseController {
  final ChatsRepository _chatsRepository;

  ChatsController(this._chatsRepository);

  final roomInfo = "".obs;
  final contactsData = <ProfileUserDto>[].obs;

  Future<void> createRoom(ProfileUserDto dto) async {
    final ourUserId = await Get.find<AuthController>().currentUserId;
    _chatsRepository.createRoom(ourUserId, dto.userId!);

    Get.offNamed("/chats-room", arguments: {
      "profile": dto,
    });
  }

  Future<void> listeningRoomInfo() async {
    await _chatsRepository.listeningRoomInfo(
      (data) {
        roomInfo.value = data as String;
      },
    );
  }

  Future<void> getContacts() async {
    try {
      final userId = await Get.find<AuthController>().currentUserId;
      final contactIds =
          Get.find<ProfileController>().profileUser.value.contacts;

      contactsData.bindStream(
        _chatsRepository.getContacts(userId, contactIds),
      );
    } on AppError catch (e) {
      showErrorSnackbar(error: e);
    }
  }
}
