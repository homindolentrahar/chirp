import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final isLogged = false;

    return isLogged ? RouteSettings(name: "/dashboard") : null;
  }
}
