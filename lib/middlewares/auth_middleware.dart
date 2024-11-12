import 'package:getx_b_dental/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {

  // @override
  // int? get priority => 0;

  @override
  RouteSettings? redirect(String? route) {
    if(sharedPreferences!.getString("jwt") != null) return const RouteSettings(name: "/home");
    return null;
  }
}