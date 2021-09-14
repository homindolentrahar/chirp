import 'package:chirp/controller/chats/chats_controller.dart';
import 'package:chirp/data/chats/chats_repository.dart';
import 'package:chirp/ui/auth/sign_in_page.dart';
import 'package:chirp/ui/auth/sign_up_page.dart';
import 'package:chirp/ui/chats/chats_page.dart';
import 'package:chirp/ui/chats/chats_room_page.dart';
import 'package:chirp/ui/chats/create_chats_page.dart';
import 'package:chirp/ui/profile/auth_profile_page.dart';
import 'package:get/get.dart';
import 'package:chirp/ui/core/splash_page.dart';
import 'package:chirp/ui/auth/landing_page.dart';

final appRoutes = <GetPage>[
  GetPage(
    name: "/",
    title: "Splash",
    page: () => const SplashPage(),
  ),
  GetPage(
    name: "/landing",
    title: "Landing",
    transition: Transition.rightToLeftWithFade,
    page: () => const LandingPage(),
  ),
  GetPage(
    name: "/sign-in",
    title: "Sign In",
    transition: Transition.downToUp,
    page: () => const SignInPage(),
  ),
  GetPage(
    name: "/sign-up",
    title: "Sign Up",
    transition: Transition.downToUp,
    page: () => const SignUpPage(),
  ),
  GetPage(
    name: "/auth-profile",
    title: "Auth Profile",
    transition: Transition.rightToLeft,
    page: () => const AuthProfilePage(),
  ),
  GetPage(
    name: "/chats",
    title: "Chats",
    transition: Transition.rightToLeftWithFade,
    binding: BindingsBuilder(() {
      final chatsRepository = Get.find<ChatsRepository>();

      Get.put<ChatsController>(ChatsController(chatsRepository));
    }),
    page: () => const ChatsPage(),
  ),
  GetPage(
    name: "/create-chats",
    title: "Create Chats",
    transition: Transition.downToUp,
    page: () => const CreateChatsPage(),
  ),
  GetPage(
    name: "/chats-room",
    title: "Chats Room",
    transition: Transition.downToUp,
    page: () => const ChatsRoomPage(),
  ),
];
