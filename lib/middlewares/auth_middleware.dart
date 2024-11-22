import 'package:getx_b_dental/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthMiddleware extends GetMiddleware {

  // @override
  // int? get priority => 0;

  @override
  RouteSettings? redirect(String? route) {
    final token = sharedPreferences!.getString("jwt");
    
    if (token != null) {
      try {
        final response = http.get(
          Uri.parse('$url/auth/token'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        response.then((value) {
          if (value.statusCode == 200) {
            return const RouteSettings(name: "/home");
          }
        });
      } catch (e) {
        // Token validation failed
      }
    }
    return null;
  }
}