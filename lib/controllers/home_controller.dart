import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/pages/home/doctor.dart';
import 'package:getx_b_dental/pages/home/patient.dart';
import 'package:getx_b_dental/pages/home/visit.dart';
import 'package:getx_b_dental/pages/home/payment.dart';

class HomeController extends GetxController {
  // Observable integer for the current index
  var currentIndex = 0.obs;

  // List of screens that corresponds to each tab
  final List<Widget> screens = [
    Doctor(),
    Patient(),
    Visit(),
    Payment(),
  ];

  // Function to change the current index
  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
}
