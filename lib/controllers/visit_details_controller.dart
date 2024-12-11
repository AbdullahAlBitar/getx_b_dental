import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class VisitDetailsController extends GetxController {
  var jwt = '';
  var id = 0;
  var name = '';
  var description = '';
  var charge = '';
  var date = '             ';
  var doctorName = '';
  var patientId = 0;
  var patientName = '';
  var patientSex = '';
  var patientPhone = '';
  var casePhotos = <Map<String, dynamic>>[];

  @override
  void onInit() {
    super.onInit();
    final visitId = Get.arguments as int?;
    if (visitId != null) {
      id = visitId;
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
        Uri.parse('$url/visits/profile/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $jwt'
        },
      );

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        name = res['name'];
        description = res['description'];
        date = res['date'];
        charge = res['charge'].toString().split('.')[0]; // Remove decimals
        doctorName = res['doctor_name'];
        patientId = res['patient_id'];
        patientName = res['patient_name'];
        patientSex = res['patient_sex'];
        patientPhone = res['patient_phone'];
        casePhotos
            .assignAll(List<Map<String, dynamic>>.from(res['case_photos']));
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

  Future<void> uploadCasePhoto() async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
  String? type;

  // Show dialog to select image type
  await Get.defaultDialog(
    title: 'Image Type',
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            type = "IntraOral";
            Get.back();
          },
          child: const Text("IntraOral"),
        ),
        TextButton(
          onPressed: () {
            type = "ExtraOral";
            Get.back();
          },
          child: const Text("ExtraOral"),
        ),
        TextButton(
          onPressed: () {
            type = "XRay";
            Get.back();
          },
          child: const Text("XRay"),
        ),
      ],
    ),
  );

  // Check if an image was picked and type is selected
  if (pickedImage == null || type == null) {
    Get.snackbar(
      'Error',
      'Please select an image and type.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
    return;
  }

  try {
    // Show loading indicator
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    // Create HTTP request
    var request = http.MultipartRequest('POST', Uri.parse('$url/casePhotos/'));

    request.headers.addAll({'Authorization': 'Bearer $jwt'});
    request.fields['visit_id'] = id.toString();
    request.fields['patient_id'] = patientId.toString();
    request.fields['date'] = DateTime.now().toIso8601String();
    request.fields['type'] = type!;

    request.files.add(await http.MultipartFile.fromPath('photo', pickedImage.path));

    // Send request
    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    // Hide loading indicator
    Get.back();

    if (response.statusCode == 200) {
      await getInfo(); // Update information after successful upload
      Get.snackbar(
        'Success',
        'Photo uploaded successfully.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } else {
      Get.snackbar(
        'Error',
        jsonDecode(responseData)['error'] ?? 'Failed to upload photo.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
  } catch (e) {
    Get.back(); // Hide loading indicator
    Get.snackbar(
      'Error',
      'An error occurred: $e',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }
}

}
