import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:getx_b_dental/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentCreateController extends GetxController {
  final amountTextCont = TextEditingController();
  DateTime? selectedDate;
  bool isLoading = false;
  String jwt = "";
  int? paymentId;
  int? patientId;
  String patientName = "";
  String patientSex = "";
  String patientPhone = "";

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
    paymentId = args?['id'];
    patientId = args?['patientId'];
    patientName = args?['patient_name'] ?? "";
    patientSex = args?['patient_sex'] ?? "";
    patientPhone = args?['patient_phone'] ?? "";

    if (paymentId != null) {
      fetchPaymentDetails();
    } else {
      selectedDate = DateTime.now();
      update(['date']);
    }
    super.onInit();
  }

  Future<void> fetchPaymentDetails() async {
    isLoading = true;
    update();

    jwt = sharedPreferences!.getString("jwt")!;

    try {
      final response = await http.get(
        Uri.parse('$url/payments/profile/$paymentId'),
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
        amountTextCont.text = data['amount'].toString();
        selectedDate = DateTime.parse(data['date']);

      } else {
        Get.snackbar('Error', 'Failed to fetch payment details');
        Get.back();
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error occurred');
      Get.back();
    }

    isLoading = false;
    update(['loading_title', 'date']);
    update();
  }

  Future<void> createOrUpdatePayment() async {
    if (patientId == null ||
        amountTextCont.text.isEmpty ||
        selectedDate == null) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    isLoading = true;
    update();

    jwt = sharedPreferences!.getString("jwt")!;

    try {
      final uri = paymentId == null
          ? Uri.parse('$url/payments/create')
          : Uri.parse('$url/payments/update/$paymentId');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt',
        },
        body: jsonEncode({
          'patient_id': patientId,
          'amount': double.parse(amountTextCont.text),
          'date': selectedDate!.toIso8601String().split('T')[0],
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.snackbar(
            'Success',
            paymentId == null
                ? 'Payment created successfully'
                : 'Payment updated successfully');
        Get.back();
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
