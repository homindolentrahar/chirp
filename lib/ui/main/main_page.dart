import 'package:chirp/controller/auth/auth_controller.dart';
import 'package:chirp/controller/auth/auth_states.dart';
import 'package:chirp/data/auth/dtos/auth_user_dto.dart';
import 'package:chirp/ui/core/widgets/buttons.dart';
import 'package:chirp/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
              FutureBuilder<AuthUserDto>(
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
                        Text(
                          data.data?.email ?? "No Email",
                          style: Get.textTheme.headline4,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          data.data?.userId ?? "No ID",
                          style: Get.textTheme.subtitle2,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Last signed in: ${DateFormat.yMMMMd().format(
                            DateTime.parse(
                              data.data?.lastSignAt ??
                                  DateTime.now().toIso8601String(),
                            ),
                          )}",
                          style: Get.textTheme.bodyText2,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Created at: ${DateFormat.yMMMMd().format(
                            DateTime.parse(
                              data.data?.createdAt ??
                                  DateTime.now().toIso8601String(),
                            ),
                          )}",
                          style: Get.textTheme.bodyText2,
                        ),
                      ],
                    );
                  } else if (data.hasError) {
                    return Text(
                      data.error.toString(),
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
