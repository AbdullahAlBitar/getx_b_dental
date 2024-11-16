import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/controllers/payment_create_controller.dart';
import 'package:getx_b_dental/pages/cards/patient_card.dart';

class PaymentCreate extends StatelessWidget {
  PaymentCreate({super.key});

  final PaymentCreateController controller = Get.put(PaymentCreateController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            GetBuilder<PaymentCreateController>(
              id: 'loading_title',
              builder: (controller) => controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Text(
                      controller.paymentId != null
                          ? "Update Payment"
                          : "Create Payment",
                      style: textTheme.titleLarge,
                    ),
            ),
            const SizedBox(height: 40),
            GetBuilder<PaymentCreateController>(
              builder: (controller) => controller.patientName.isNotEmpty
                  ? PatientCard(
                      controller.patientId!,
                      controller.patientName,
                      controller.patientPhone,
                      controller.patientSex == "Male" ? 1 : 0)
                  : const SizedBox(),
            ),
            const SizedBox(height: 20),
            GetBuilder<PaymentCreateController>(
                builder: (controller) => TextField(
                      style: textTheme.labelMedium,
                      controller: controller.amountTextCont,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Amount",
                      ),
                    )),
            const SizedBox(height: 20),
            GetBuilder<PaymentCreateController>(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Icon(Icons.arrow_back),
                ),
                GetBuilder<PaymentCreateController>(
                  id: 'loading_title',
                  builder: (controller) => ElevatedButton(
                    onPressed: controller.isLoading
                        ? null
                        : () => controller.createOrUpdatePayment(),
                    child: Text("Submit", style: textTheme.labelMedium),
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
