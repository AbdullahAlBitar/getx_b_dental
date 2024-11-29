import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/controllers/visit_create_controller.dart';
import 'package:getx_b_dental/pages/cards/patient_card.dart';

class VisitCreate extends StatelessWidget {
  VisitCreate({super.key});

  final VisitCreateController controller = Get.put(VisitCreateController());
  final FocusNode phoneFocus = FocusNode();
  final FocusNode descriptionFocus = FocusNode();
  final FocusNode chargeFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<VisitCreateController>(
                id: 'loading_title',
                builder: (controller) => controller.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Text(
                        controller.visitId != null
                            ? "Update Visit"
                            : "Create Visit",
                        style: textTheme.titleLarge,
                      ),
              ),
              const SizedBox(height: 40),
              
              // Name Field
              TextField(
                style: textTheme.labelMedium,
                controller: controller.nameTextCont,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: "Name",
                ),
                onSubmitted: (_) {
                  controller.patientName.isNotEmpty?
                  FocusScope.of(context).requestFocus(descriptionFocus):
                  FocusScope.of(context).requestFocus(phoneFocus);
                },
              ),
              const SizedBox(height: 20),

              // Phone Field
              GetBuilder<VisitCreateController>(
              builder: (controller) => controller.patientName.isNotEmpty
                  ? PatientCard(
                      controller.patientId!,
                      controller.patientName,
                      controller.patientPhone,
                      controller.patientSex == "Male" ? 1 : 0)
                  :TextField(
                keyboardType: TextInputType.number,
                style: textTheme.labelMedium,
                controller: controller.phoneTextCont,
                focusNode: phoneFocus,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: "Phone",
                ),
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(descriptionFocus);
                },
              )),
              const SizedBox(height: 20),

              // Description Field
              TextField(
                style: textTheme.labelMedium,
                controller: controller.descriptionTextCont,
                focusNode: descriptionFocus,
                textInputAction: TextInputAction.next,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(chargeFocus);
                },
              ),
              const SizedBox(height: 20),

              // Charge Field
              TextField(
                keyboardType: TextInputType.number,
                style: textTheme.labelMedium,
                controller: controller.chargeTextCont,
                focusNode: chargeFocus,
                decoration: const InputDecoration(
                  hintText: "Charge",
                ),
              ),
              const SizedBox(height: 20),

              // Date Picker
              GetBuilder<VisitCreateController>(
                id: 'date',
                builder: (controller) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      style: textTheme.labelSmall,
                      controller.selectedDate == null
                          ? "Date: (Not Selected)"
                          : "Date: ${controller.selectedDate!.toString().split(' ')[0]}",
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: controller.selectedDate ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          controller.setDate(picked);
                        }
                      },
                      child: Text(
                        "Select Date",
                        style: textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Icon(Icons.arrow_back),
                  ),
                  GetBuilder<VisitCreateController>(
                    id: 'loading_title',
                    builder: (controller) => ElevatedButton(
                      onPressed: controller.isLoading
                          ? null
                          : () => controller.createOrUpdateVisit(),
                      child: Text("Submit", style: textTheme.labelMedium),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}