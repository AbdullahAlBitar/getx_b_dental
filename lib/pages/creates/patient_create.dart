import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/controllers/patient_create_controller.dart';

class PatientCreate extends StatelessWidget {
  PatientCreate({super.key});

  final PatientCreateController controller = Get.put(PatientCreateController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            GetBuilder<PatientCreateController>(
              id: 'loading_title',
              builder: (controller) => controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Text(
                      controller.patientId != null
                          ? "Update Patient"
                          : "Create Patient",
                      style: textTheme.titleLarge,
                    ),
            ),
            const SizedBox(height: 40),

            // Name Field
            TextField(
              style: textTheme.labelMedium,
              controller: controller.nameTextCont,
              decoration: const InputDecoration(
                hintText: "Name",
              ),
            ),
            const SizedBox(height: 20),

            // Phone Field
            TextField(
              style: textTheme.labelMedium,
              controller: controller.phoneTextCont,
              enabled: controller.isPhoneEditable,
              decoration: const InputDecoration(
                hintText: "Phone",
              ),
            ),
            const SizedBox(height: 20),

            // Birthdate Picker
            GetBuilder<PatientCreateController>(
              id: 'birthdate',
              builder: (controller) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    style: textTheme.labelSmall,
                    controller.selectedBirthdate == null
                        ? "Birthdate: (Not Selected)"
                        : "Birthdate: ${controller.selectedBirthdate!.toString().split(' ')[0]}"
                            ,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate:
                            controller.selectedBirthdate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        controller.setBirthdate(picked);
                      }
                    },
                    child: Text("Select Birthdate",
                    style: textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Sex Radio Buttons
            GetBuilder<PatientCreateController>(
              id: 'sex',
              builder: (controller) => Column(
                children: [
                  RadioListTile<String>(
                    title: Text("Male", style: textTheme.labelMedium,),
                    value: "Male",
                    groupValue: controller.selectedSex,
                    onChanged: (value) => controller.setSex(value),
                  ),
                  RadioListTile<String>(
                    title: Text("Female", style: textTheme.labelMedium,),
                    value: "Female",
                    groupValue: controller.selectedSex,
                    onChanged: (value) => controller.setSex(value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Submit Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back),
                ),
                GetBuilder<PatientCreateController>(
                  id: 'loading_title',
                  builder: (controller) => ElevatedButton(
                    onPressed: controller.isLoading
                        ? null
                        : () => controller.createOrUpdatePatient(),
                    child: Text("Submit", style: textTheme.labelMedium,),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
