import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/main.dart';
import 'package:getx_b_dental/pages/home/doctor.dart';
import 'package:getx_b_dental/pages/home/patient.dart';
import 'package:getx_b_dental/pages/home/visit.dart';
import 'package:getx_b_dental/pages/home/payment.dart';
import 'package:http/http.dart' as http;


class HomeController extends GetxController {
  // Observable integer for the current index
  var currentIndex = 0;

  // List of screens that corresponds to each tab
  final List<Widget> screens = [
    Doctor(),
    Patient(),
    Visit(),
    Payment(),
  ];

  @override
  void onInit() {
    checkToken();
    super.onInit();
  }

  Future<void> checkToken() async {
    try {
      final token = sharedPreferences!.getString("jwt");

      final response = await http.get(
        Uri.parse('$url/auth/token'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Get.offAllNamed('/');
      }
    } catch (e) {
        Get.offAllNamed('/');
    }
  }

  // Function to change the current index
  void changeTabIndex(int index) {
    currentIndex = index;
    update();
  }
}
