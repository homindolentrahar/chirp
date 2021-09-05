import 'package:chirp/controller/auth/auth_controller.dart';
import 'package:chirp/data/auth_repository.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    final supabase = Get.put<Supabase>(Supabase.instance);
    final authRepository =
        Get.put<AuthRepository>(AuthRepository(supabase: supabase));

    Get.put<AuthController>(AuthController(authRepository: authRepository));
  }
}
