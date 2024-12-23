import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class PatientController extends GetxController {
  var jwt = '';
  var patients = <Map<String, dynamic>>[];
  var filteredPatients = <Map<String, dynamic>>[];

  @override
  void onInit() {
    super.onInit();
    getInfo();
  }

  Future<void> getInfo() async {
    jwt = sharedPreferences!.getString('jwt') ?? '';
    if (jwt.isEmpty) {
      Get.offAllNamed("/"); // Navigate to login if JWT is missing
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('$url/patients/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $jwt',
        },
      );

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        patients.assignAll(List<Map<String, dynamic>>.from(res));
        filteredPatients.assignAll(patients); // Initialize filtered list
        update();
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

  void filterPatients(String query) {
    if (query.isEmpty) {
      filteredPatients = List.from(patients);
    } else {
      filteredPatients = patients.where((p) {
        final nameLower = p['name'].toString().toLowerCase();
        final phoneLower = p['phone'].toString().toLowerCase();
        final searchLower = query.toLowerCase();
        return nameLower.contains(searchLower) || phoneLower.contains(searchLower);
      }).toList();
    }
    update();
  }
}