import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class PatientDetailsController extends GetxController {
  var jwt = ''.obs;
  var id = 0.obs;
  var name = ''.obs;
  var phone = ''.obs;
  var sex = ''.obs;
  var dues = ''.obs;
  var visits = <Map<String, dynamic>>[].obs;
  var payments = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    final patientId = Get.arguments as int?;
    if (patientId != null) {
      id.value = patientId;
      getInfo();
    }
  }

  Future<void> getInfo() async {
    jwt.value = sharedPreferences!.getString('jwt') ?? '';
    if (jwt.isEmpty) {
      Get.offAllNamed("/");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('$url/patients/profile/${id.value}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${jwt.value}',
        },
      );

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        name.value = res['name'];
        phone.value = res['phone'];
        sex.value = res['sex'];
        dues.value = res['dues'].toString().split('.')[0]; // Remove decimal
        visits.assignAll(List<Map<String, dynamic>>.from(res['visits']));
        payments.assignAll(List<Map<String, dynamic>>.from(res['payments']));
      } else {
        final res = jsonDecode(response.body);
        Get.snackbar("Error", res['error']);
        Get.offAllNamed("/");
      }
    } catch (e) {
      Get.snackbar("Network Error", 'Please try again later.');
    }
  }

  Future<void> logOut() async {
    sharedPreferences!.remove("login");
    Get.offAllNamed("/");
  }
}
