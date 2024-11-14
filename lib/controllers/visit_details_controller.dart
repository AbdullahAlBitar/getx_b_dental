import 'package:get/get.dart';
import 'package:getx_b_dental/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VisitDetailsController extends GetxController {
  var jwt = '';
  var id = 0.obs;
  var name = ''.obs;
  var description = ''.obs;
  var charge = ''.obs;
  var date = '             '.obs;
  var doctorName = ''.obs;
  var patientId = 0.obs;
  var patientName = ''.obs;
  var patientSex = ''.obs;
  var patientPhone = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final visitId = Get.arguments as int?;
    if (visitId != null) {
      id.value = visitId;
      getInfo();
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
        Uri.parse('$url/visits/profile/${id.value}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $jwt'
          },
      );

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        name.value = res['name'];
        description.value = res['description'];
        date.value = res['date'];
        charge.value = res['charge'].toString().split('.')[0]; // Remove decimals
        doctorName.value = res['doctor_name'];
        patientId.value = res['patient_id'];
        patientName.value = res['patient_name'];
        patientSex.value = res['patient_sex'];
        patientPhone.value = res['patient_phone'];
      } else {
        final res = jsonDecode(response.body);
        Get.snackbar("Error", res["error"]);
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
