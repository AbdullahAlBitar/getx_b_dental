import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class PatientDetailsController extends GetxController {
  var jwt = '';
  var id = 0;
  var name = '';
  var phone = '';
  var sex = '';
  var dues = '';
  var birthdate = '';
  var visits = <Map<String, dynamic>>[];
  var payments = <Map<String, dynamic>>[];

  @override
  void onInit() {
    super.onInit();
    final patientId = Get.arguments as int?;
    if (patientId != null) {
      id = patientId;
      getInfo();
    }else{
      Get.back();
    }
  }

  Future<void> getInfo() async {
    jwt = sharedPreferences!.getString('jwt') ?? '';
    if (jwt.isEmpty) {
      Get.offAllNamed("/");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('$url/patients/profile/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $jwt',
        },
      );

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        name = res['name'];
        phone = res['phone'];
        sex = res['sex'];
        dues = res['dues'].toString().split('.')[0]; // Remove decimal
        birthdate = (DateTime.parse(res['birth']).toString().split(' ')[0]);
        visits.assignAll(List<Map<String, dynamic>>.from(res['visits']));
        payments.assignAll(List<Map<String, dynamic>>.from(res['payments']));
        update();
      } else {
        final res = jsonDecode(response.body);
        Get.snackbar("Error", res['error']);
        Get.offAllNamed("/");
      }
    } catch (e) {
      Get.snackbar("Network Error", 'Please try again later.');
    }  }

  Future<void> logOut() async {
    sharedPreferences!.remove("login");
    Get.offAllNamed("/");
  }
}
