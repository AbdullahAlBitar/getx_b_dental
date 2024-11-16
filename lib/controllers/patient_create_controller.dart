import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:getx_b_dental/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PatientCreateController extends GetxController {
  final nameTextCont = TextEditingController();
  final phoneTextCont = TextEditingController();
  DateTime? selectedBirthdate;
  String? selectedSex;
  bool isLoading = false;
  bool isPhoneEditable = true;
  String jwt = "";
  int? patientId;

  void setBirthdate(DateTime? date) {
    selectedBirthdate = date;
    update(['birthdate']);
  }

  void setSex(String? sex) {
    selectedSex = sex;
    update(['sex']);
  }

  void setLoading(bool value) {
    isLoading = value;
    update(['loading_title']);
  }

  @override
  void onInit() {
    patientId = Get.arguments?['id'];
    fetchPatientDetails();
    super.onInit();
  }

  Future<void> fetchPatientDetails() async {
    if (patientId == null) return;

    isLoading = true;
    update();

    jwt = sharedPreferences!.getString("jwt")!;

    try {
      final response = await http.get(
        Uri.parse('$url/patients/$patientId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $jwt',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        nameTextCont.text = data['name'];
        phoneTextCont.text = data['phone'];
        selectedBirthdate = DateTime.parse(data['birth']);
        selectedSex = data['sex'];
        isPhoneEditable = false;
      } else {
        Get.snackbar('Error', 'Failed to fetch patient details');
        Get.back();
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error occurred');
      Get.back();
    }

    isLoading = false;
    update();
    update(['birthdate', 'sex', 'loading_title']);
  }

  Future<void> createOrUpdatePatient() async {
    if (nameTextCont.text.isEmpty ||
        phoneTextCont.text.isEmpty ||
        selectedBirthdate == null ||
        selectedSex == null) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    isLoading = true;
    update();

    jwt = sharedPreferences!.getString("jwt")!;

    try {
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwt',
      };

      final uri = patientId == null
          ? Uri.parse('$url/patients')
          : Uri.parse('$url/patients/$patientId');

      http.Response response;
      if (patientId == null) {
        response = await http.post(
          uri,
          headers: headers,
          body: jsonEncode({
            'name': nameTextCont.text,
            'phone': phoneTextCont.text,
            'birth': selectedBirthdate!.toIso8601String(),
            'sex': selectedSex,
          }),
        );
      } else {
        response = await http.patch(
          uri,
          headers: headers,
          body: jsonEncode({
            'name': nameTextCont.text,
            'birth': selectedBirthdate!.toIso8601String(),
            'sex': selectedSex,
          }),
        );
      }

      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.snackbar(
            'Success',
            patientId == null
                ? 'Patient created successfully'
                : 'Patient updated successfully');
        Get.offNamedUntil("/home", (route) => route.settings.name == '/');
      } else {
        final res = jsonDecode(response.body);
        Get.snackbar('Error', res['error']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error occurred');
    }

    isLoading = false;
    update();
  }
}
