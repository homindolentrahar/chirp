import 'package:chirp/controller/auth/auth_controller.dart';
import 'package:chirp/controller/auth/auth_states.dart';
import 'package:chirp/ui/core/widgets/buttons.dart';
import 'package:chirp/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase/supabase.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends AuthRequiredState<MainPage> {
  late AuthController authController;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<User>(
                future: authController.getCurrentUser(),
                builder: (ctx, data) {
                  if (data.connectionState == ConnectionState.waiting) {
                    return Text(
                      "Loading",
                      style: Get.textTheme.bodyText2,
                    );
                  } else if (data.hasData) {
                    return Column(
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          data.data?.email ?? "No Email",
                          style: Get.textTheme.headline4,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          DateFormat.yMMMMd().format(
                            DateTime.parse(data.data!.lastSignInAt!),
                          ),
                          style: Get.textTheme.bodyText2,
                        ),
                      ],
                    );
                  } else {
                    return Text(
                      "You most likely unable to see this texts if it's worked",
                    );
                  }
                },
              ),
              const SizedBox(height: 24),
              FilledButton(
                text: "Logout",
                textColor: Get.theme.canvasColor,
                backgroundColor: AppColor.white,
                onPressed: () {
                  authController.signOut().then(
                    (_) {
                      Get.offAllNamed("/landing");
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
