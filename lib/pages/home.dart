import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/controllers/delete_controller.dart';
import 'package:getx_b_dental/controllers/doctor_controller.dart';
import 'package:getx_b_dental/controllers/home_controller.dart';
import 'package:getx_b_dental/controllers/patient_controller.dart';
import 'package:getx_b_dental/controllers/payment_conrtoller.dart';
import 'package:getx_b_dental/controllers/visit_controller.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final doctorController = Get.lazyPut(() => DoctorController(), fenix: true);
  final patientController = Get.lazyPut(() => PatientController(), fenix: true);
  final paymentController = Get.lazyPut(() => PaymentController(), fenix: true);
  final visitController = Get.lazyPut(() => VisitController(), fenix: true);
  final deleteController = Get.lazyPut(() => DeleteController(), fenix: true);
  final HomeController controller = Get.put(HomeController(), permanent: true);

  final List<BottomNavigationBarItem> desNav = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined),
        label: "Doctor",
        activeIcon: Icon(Icons.account_circle_rounded)),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sick_outlined),
        label: "Patients",
        activeIcon: Icon(Icons.sick)),
    const BottomNavigationBarItem(
        icon: Icon(Icons.view_timeline_outlined),
        label: "Visits",
        activeIcon: Icon(Icons.view_timeline)),
    const BottomNavigationBarItem(
        icon: Icon(Icons.payments_outlined),
        label: "Payments",
        activeIcon: Icon(Icons.payments)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
          builder: (controller) => controller.screens[controller.currentIndex]),
      bottomNavigationBar: GetBuilder<HomeController>(
          builder: (controller) => BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: controller.currentIndex,
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
