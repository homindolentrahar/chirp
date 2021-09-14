import 'package:chirp/controller/auth/auth_controller.dart';
import 'package:chirp/controller/profile/profile_controller.dart';
import 'package:chirp/data/auth/auth_repository.dart';
import 'package:chirp/data/chats/chats_repository.dart';
import 'package:chirp/data/profile/profile_repository.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    final supabase = Get.put<Supabase>(Supabase.instance);
    final socketIO = Get.find<Socket>();
    //  Repositories
    final authRepository =
        Get.put<AuthRepository>(AuthRepository(supabase: supabase));
    final profileRepository =
        Get.put<ProfileRepository>(ProfileRepository(supabase: supabase));
    final chatsRepository = Get.put<ChatsRepository>(
      ChatsRepository(
        supabase: supabase,
        socketIO: socketIO,
      ),
    );

    Get.put<AuthController>(
      AuthController(authRepository: authRepository),
    );
    Get.put<ProfileController>(
      ProfileController(profileRepository: profileRepository),
    );
  }
}
