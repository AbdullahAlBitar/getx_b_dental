import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController extends GetxController {
  final phoneTextCont = TextEditingController();
  final passwordTextCont = TextEditingController();
  final passwordConfirmTextCont = TextEditingController();
  final nameTextCont = TextEditingController();

  final isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;

    if (phoneTextCont.text.isEmpty || passwordTextCont.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Phone & Password are required",
      );
      isLoading.value = false;
      return;
    }

    try {
      final response = await http
          .post(
        Uri.parse('$url/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': phoneTextCont.text,
          'password': passwordTextCont.text,
        }),
      )
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Request timed out');
      });

      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        final jwt = data['jwt'];
        sharedPreferences!.setString("jwt", jwt);

        phoneTextCont.clear();
        passwordTextCont.clear();
        Timer(const Duration(minutes: 30), () {
          sharedPreferences!.clear();
        });

        Get.toNamed("/home");
        Get.snackbar(
          "Success",
          "Logged in successfully",
        );
      } else {
        Get.snackbar(
          "Error",
          data['error'],
        );
      }
    } on TimeoutException {
      Get.snackbar(
        "Error",
        "Request timed out. Please try again.",
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Network error. Please try again later.",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
