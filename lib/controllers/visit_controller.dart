import 'package:get/get.dart';
import 'package:getx_b_dental/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VisitController extends GetxController {
  var jwt = ''.obs;
  var visits = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    getInfo();
  }

  Future<void> getInfo() async {
    jwt.value = sharedPreferences!.getString('jwt') ?? '';
    if (jwt.value.isEmpty) {
      Get.offAllNamed("/"); // Navigate to login if JWT is missing
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('$url/visits/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${jwt.value}',
        },
      );

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        visits.assignAll(List<Map<String, dynamic>>.from(res));
      } else {
        final res = jsonDecode(response.body);
        Get.snackbar("Error", res['error']);
        sharedPreferences!.setBool('login', true);
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
