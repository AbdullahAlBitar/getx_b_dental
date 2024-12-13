import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/middlewares/auth_middleware.dart';
import 'package:getx_b_dental/pages/auth/login.dart';
import 'package:getx_b_dental/pages/auth/signup.dart';
import 'package:getx_b_dental/pages/creates/patient_create.dart';
import 'package:getx_b_dental/pages/creates/payment_create.dart';
import 'package:getx_b_dental/pages/creates/visit_create.dart';
import 'package:getx_b_dental/pages/details/patient_details.dart';
import 'package:getx_b_dental/pages/details/payment_details.dart';
import 'package:getx_b_dental/pages/details/visit_details.dart';
import 'package:getx_b_dental/pages/home.dart';
import 'package:getx_b_dental/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
// const url = "http://192.168.1.17:3000";
// const url = "http://192.168.137.1:3000";
const url = "https://b-dental.onrender.com";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Demo',
      themeMode: ThemeMode.system,
      theme: Themes.light,
      darkTheme: Themes.dark,
      getPages: [
        GetPage(name: "/", page: () => Login(), middlewares: [
          AuthMiddleware()
        ]),
        GetPage(name: "/signup", page: () => SignUp()),
        GetPage(name: "/home", page: () => Home()),
        GetPage(name: "/patientDetails", page: () => PatientDetails()),
        GetPage(name: "/paymentDetails", page: () => PaymentDetails()),
        GetPage(name: "/visitDetails", page: () => VisitDetails()),
        GetPage(name: "/patientCreate", page: () => PatientCreate()),
        GetPage(name: "/paymentCreate", page: () => PaymentCreate()),
        GetPage(name: "/visitCreate", page: () => VisitCreate()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
