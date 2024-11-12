import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/controllers/home_controller.dart';


class Home extends StatelessWidget {
  Home({super.key});

  final HomeController controller = Get.put(HomeController(), permanent: true);

  final List<BottomNavigationBarItem> desNav = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined), label: "Doctor", activeIcon: Icon(Icons.account_circle_rounded)),
    const BottomNavigationBarItem(icon: Icon(Icons.sick_outlined), label: "Patients", activeIcon: Icon(Icons.sick)),
    const BottomNavigationBarItem(
        icon: Icon(Icons.view_timeline_outlined), label: "Visits", activeIcon: Icon(Icons.view_timeline)),
    const BottomNavigationBarItem(
        icon: Icon(Icons.payments_outlined), label: "Payments", activeIcon: Icon(Icons.payments)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.screens[controller.currentIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              controller.changeTabIndex(index);
            },
            items: desNav,
            unselectedItemColor: Colors.cyanAccent[900],
            elevation: 5,
          )),
    );
  }
}
