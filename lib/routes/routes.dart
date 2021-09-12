import 'package:chirp/ui/auth/sign_in_page.dart';
import 'package:chirp/ui/auth/sign_up_page.dart';
import 'package:chirp/ui/chats/chats_page.dart';
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
    page: () => const ChatsPage(),
  ),
];
