import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/middlewares/auth_middleware.dart';
import 'package:getx_b_dental/pages/auth/login.dart';
import 'package:getx_b_dental/pages/auth/signup.dart';
import 'package:getx_b_dental/pages/details/patient_details.dart';
import 'package:getx_b_dental/pages/details/payment_details.dart';
import 'package:getx_b_dental/pages/details/visit_details.dart';
import 'package:getx_b_dental/pages/home.dart';
import 'package:getx_b_dental/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
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
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
