import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:getx_b_dental/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VisitCreateController extends GetxController {
  final nameTextCont = TextEditingController();
  final phoneTextCont = TextEditingController();
  final descriptionTextCont = TextEditingController();
  final chargeTextCont = TextEditingController();

  DateTime? selectedDate;
  bool isLoading = false;
  String jwt = "";
  int? visitId;
  int? patientId;
  String patientName = "";
  String patientSex = "";
  String patientPhone = "";
  String doctorName = "";

  void setDate(DateTime? date) {
    selectedDate = date;
    update(['date']);
  }

  void setLoading(bool value) {
    isLoading = value;
    update(['loading_title']);
  }

  @override
  void onInit() {
    final args = Get.arguments;
    visitId = args?['id'];
    patientId = args?['patientId'];
    patientName = args?['patient_name'] ?? "";
    patientSex = args?['patient_sex'] ?? "";
    patientPhone = args?['patient_phone'] ?? "";

    if (visitId != null) {
      fetchVisitDetails();
    } else {
      selectedDate = DateTime.now();
      update(['date']);
    }
    super.onInit();
  }

  Future<void> fetchVisitDetails() async {
    setLoading(true);
    jwt = sharedPreferences!.getString("jwt")!;

    try {
      final response = await http.get(
        Uri.parse('$url/visits/profile/$visitId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $jwt',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        patientId = data['patient_id'];
        patientName = data['patient_name'];
        patientSex = data['patient_sex'];
        patientPhone = data['patient_phone'];
        nameTextCont.text = data['name'];
        descriptionTextCont.text = data['description'];
        chargeTextCont.text = data['charge'].toString();
        selectedDate = DateTime.parse(data['date']);
        doctorName = data['doctor_name'];
        update();
      } else {
        Get.snackbar('Error', 'Failed to fetch visit details');
        Get.back();
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error occurred');
      Get.back();
    }

    setLoading(false);
  }

  Future<void> createOrUpdateVisit() async {
    if ((patientId == null && phoneTextCont.text.isEmpty) ||
        nameTextCont.text.isEmpty ||
        descriptionTextCont.text.isEmpty ||
        chargeTextCont.text.isEmpty ||
        selectedDate == null) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    setLoading(true);
    jwt = sharedPreferences!.getString("jwt")!;

    try {
      final uri = visitId == null
          ? Uri.parse('$url/visits/')
          : Uri.parse('$url/visits/$visitId');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      };

      Map<String, dynamic> requestBody = {
        if (patientId != null) 'patient_id': patientId,
        if (phoneTextCont.text.isNotEmpty) 'phone': phoneTextCont.text,
        'name': nameTextCont.text,
        'description': descriptionTextCont.text,
        'charge': double.parse(chargeTextCont.text),
        'date': selectedDate!.toIso8601String().split('T')[0],
      };

      final response = await (visitId == null
          ? http.post(uri, headers: headers, body: jsonEncode(requestBody))
          : http.patch(uri, headers: headers, body: jsonEncode(requestBody)));

      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.snackbar(
            'Success',
            visitId == null
                ? 'Visit created successfully'
                : 'Visit updated successfully');
        Get.offNamedUntil("/home", (route) => route.settings.name == '/');
      } else {
        final res = jsonDecode(response.body);
        Get.snackbar('Error', res['error']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error occurred');
    }

    setLoading(false);
  }
}