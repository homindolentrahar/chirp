import 'package:chirp/routes/middlewares.dart';
import 'package:chirp/ui/auth/sign_in_page.dart';
import 'package:chirp/ui/auth/sign_up_page.dart';
import 'package:chirp/ui/main/main_page.dart';
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
    middlewares: [AuthMiddleware()],
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
    name: "/main",
    title: "Main",
    transition: Transition.rightToLeftWithFade,
    page: () => const MainPage(),
  ),
];
