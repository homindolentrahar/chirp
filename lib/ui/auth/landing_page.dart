import 'package:chirp/ui/core/widgets/buttons.dart';
import 'package:chirp/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "assets/images/landing.svg",
                height: 240,
              ),
              const SizedBox(height: 24),
              Text(
                "Let\'s have a good conversation!",
                style: Get.textTheme.headline2,
              ),
              const SizedBox(height: 8),
              Text(
                "Good conversation has never been a problem for someone, so let's talk and share story",
                style: Get.textTheme.bodyText2,
              ),
              const SizedBox(height: 48),
              Row(
                children: [
                  Expanded(
                    child: BorderedButton(
                      text: "Sign Up",
                      color: AppColor.white,
                      onPressed: () {
                        Get.toNamed("/sign-up");
                      },
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: FilledButton(
                      text: "Sign In",
                      textColor: AppColor.black,
                      backgroundColor: AppColor.white,
                      onPressed: () {
                        Get.toNamed("/sign-in");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
