import 'package:get/get.dart';
import 'package:getx_b_dental/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentDetailsController extends GetxController {
  var jwt = '';
  var id = 0;
  var amount = '';
  var date = '             ';
  var doctorName = '';
  var patientId = 0;
  var patientName = '';
  var patientSex = '';
  var patientPhone = '';

  @override
  void onInit() {
    super.onInit();
    final paymentId = Get.arguments as int?;
    if (paymentId != null) {
      id = paymentId;
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
        Uri.parse('$url/payments/profile/$id'),
        headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwt'
        },
      );

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        amount = res['amount'].toString().split('.')[0]; // Remove decimals
        date = res['date'];
        doctorName = res['doctor_name'];
        patientId = res['patient_id'];
        patientName = res['patient_name'];
        patientSex = res['patient_sex'];
        patientPhone = res['patient_phone'];
        update();
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
