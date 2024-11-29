import 'package:get/get.dart';
import 'package:getx_b_dental/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VisitCreateController extends GetxController {
  String jwt = "";
  int? id;
  String name = "";
  String description = "";
  String charge = "";
  DateTime? selectedDate;
  
  String doctorName = "";

  int patientId = 0;
  String patientName = "";
  String patientSex = "";
  String patientPhone = "";

  @override
  void onInit() {
    id = Get.arguments?["id"];
    if(id != null){
      getInfo();
    }else{
      selectedDate = DateTime.now();
      update(['date']);
    }
    super.onInit();
  }

  Future<void> getInfo() async {
    jwt = sharedPreferences!.getString('jwt') ?? '';
    if (jwt.isEmpty) {
      Get.offNamed("/"); // Navigate to the login page if JWT is missing
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('$url/visits/profile/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'jwt': jwt}),
      );

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        name = res['name'];
        description = res['description'];
        selectedDate = DateTime.parse(res['date']);
        charge = res['charge'].toString();
        if (charge.contains(".")) {
          charge = res['charge']
              .toString()
              .substring(0, res['charge'].toString().indexOf("."));
        }
        patientId = res['patient_id'];
        doctorName = res['doctor_name'];
        patientName = res['patient_name'];
        patientSex = res['patient_sex'];
        patientPhone = res['patient_phone'];
        update();
      } else {
        final res = jsonDecode(response.body);
        Get.snackbar("Error", res["error"]);
        sharedPreferences!.setBool('login', true);
        Get.offNamed("/");
      }
    } catch (e) {
      Get.snackbar("Error", "Network error. Please try again later.");
    }
  }

  Future<void> logOut() async {
    (await SharedPreferences.getInstance()).remove("login");
    Get.offNamed("/");
  }
}
