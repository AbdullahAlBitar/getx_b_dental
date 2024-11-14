import 'package:get/get.dart';
import 'package:getx_b_dental/controllers/payment_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:getx_b_dental/pages/cards/nav_bar.dart';
import 'package:getx_b_dental/pages/cards/patient_card.dart';

class PaymentDetails extends StatelessWidget {
  PaymentDetails({super.key});

  final PaymentDetailsController controller =
      Get.put(PaymentDetailsController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GetBuilder<PaymentDetailsController>(
                            builder: (controller) => Text(
                                  controller.amount,
                                  style: textTheme.titleLarge,
                                )),
                        Text(
                          ' SYP',
                          style: textTheme.labelLarge,
                        ),
                      ],
                    ),
                    GetBuilder<PaymentDetailsController>(
                        builder: (controller) => IconButton(
                              onPressed: () {
                                Get.toNamed("/paymentUpdate", arguments: {
                                  'id': controller.id,
                                  'patientId': controller.patientId
                                });
                              },
                              icon: const Icon(
                                Icons.edit_note_rounded,
                                size: 36,
                              ),
                            )),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GetBuilder<PaymentDetailsController>(
                      builder: (controller) => Text(
                            controller.date.substring(0, 10),
                            softWrap: true,
                            style: textTheme.labelMedium,
                          )),
                ],
              ),
              Divider(color: theme.dividerColor),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Dr. ',
                        style: textTheme.titleSmall,
                      ),
                      GetBuilder<PaymentDetailsController>(
                          builder: (controller) => Text(
                                controller.doctorName,
                                style: textTheme.labelLarge,
                              )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GetBuilder<PaymentDetailsController>(
                      builder: (controller) => PatientCard(
                            controller.patientId,
                            controller.patientName,
                            controller.patientPhone,
                            controller.patientSex == "Male" ? 1 : 0,
                          )),
                  const SizedBox(height: 20),
                ],
              ),
              GetBuilder<PaymentDetailsController>(
                  builder: (controller) => NavBar('payment', controller.id)),
            ],
          ),
        ),
      ),
    );
  }
}
