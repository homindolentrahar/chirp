import 'package:chirp/controller/auth/auth_states.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends AuthState<SplashPage> {
  @override
  void initState() {
    Future.delayed(3.seconds, () {
      recoverSupabaseSession();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SvgPicture.asset(
            "assets/images/logo_fill.svg",
            width: 48,
            height: 48,
          ),
        ),
      ),
    );
  }
}
