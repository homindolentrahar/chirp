import 'package:chirp/ui/core/widgets/snackbars.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gotrue/src/session.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState {
  @override
  void onAuthenticated(Session session) {
    if (mounted) {
      Get.offAllNamed("/main");
    }
  }

  @override
  void onUnauthenticated() {
    if (mounted) {
      Get.offAllNamed("/landing");
    }
  }

  @override
  void onErrorAuthenticating(String message) {
    Get.showSnackbar(
      Snackbars.appSnackbar(
        title: "Authentication error",
        message: message,
        type: SnackbarType.ERROR,
      ),
    );
  }

  @override
  void onPasswordRecovery(Session session) {}

  @override
  void onErrorReceivingDeeplink(String message) {
    Get.showSnackbar(
      Snackbars.appSnackbar(
        title: "Authentication error",
        message: message,
        type: SnackbarType.ERROR,
      ),
    );
  }
}

class AuthRequiredState<T extends StatefulWidget>
    extends SupabaseAuthRequiredState {
  @override
  void onUnauthenticated() {
    Get.offAllNamed("/landing");
  }
}
