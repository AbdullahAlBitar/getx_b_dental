import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';


class DoctorController extends GetxController {
  String name = '';
  String phone = '';
  String dues = '';
  List<Map<String, dynamic>> visits = [];

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    String jwt = sharedPreferences!.getString('jwt') ?? '';

    if (jwt.isEmpty) {
      Get.offAllNamed("/"); // Navigate to login if JWT is missing
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('$url/doctors/profile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $jwt'
        },
      );

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        name = res['name'];
        phone = res['phone'];
        dues = res['dues'].toString().split(".")[0];
        visits = List<Map<String, dynamic>>.from(res['visits']);
        update(); // Add this to trigger UI update
      } else {
        final res = jsonDecode(response.body);
        Get.snackbar("Error", res['error']);
        sharedPreferences!.clear();
        Get.offAllNamed("/");
      }
    } catch (e) {
      Get.snackbar("Network Error", 'Please try again later.');
    }
  }

  Future<void> logOut() async {
    sharedPreferences!.clear();
    Get.offAllNamed("/");
  }
}