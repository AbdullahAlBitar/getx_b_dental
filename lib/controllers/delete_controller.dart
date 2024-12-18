import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_b_dental/main.dart';
import 'package:http/http.dart' as http;

class DeleteController extends GetxController {
  Future<void> deleteItem(int id, String type) async {
    String jwt = sharedPreferences!.getString('jwt') ?? '';

    if (jwt.isEmpty) {
      Get.offAllNamed("/"); // Navigate to login if JWT is missing
      return;
    }
    
    try {
      final response = await http.delete(
        Uri.parse('$url/${type}s/$id'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar(
          'Success',
          'Item deleted successfully',
        );
      } else {
        final res = jsonDecode(response.body);
        Get.snackbar("Error", res['error']);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Network error occurred',
      );
    }
  }
}