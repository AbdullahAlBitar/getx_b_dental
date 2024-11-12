import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';


class DoctorController extends GetxController {
  var jwt = ''.obs;
  var name = ''.obs;
  var phone = ''.obs;
  var dues = ''.obs;
  var visits = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  Future<void> getUserInfo() async {

    jwt.value = sharedPreferences!.getString('jwt') ?? '';

    if (jwt.value.isEmpty) {
      Get.offAllNamed("/"); // Navigate to login if JWT is missing
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('$url/doctors/profile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${jwt.value}'
        },
      );

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        name.value = res['name'];
        phone.value = res['phone'];
        dues.value = res['dues'].toString().split(".")[0];
        visits.assignAll(List<Map<String, dynamic>>.from(res['visits']));
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
