import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/controllers/patient_details_controller.dart';
import 'package:getx_b_dental/pages/cards/nav_bar.dart';
import 'package:getx_b_dental/pages/cards/payment_card.dart';
import 'package:getx_b_dental/pages/cards/visit_card.dart';

class PatientDetails extends StatelessWidget {
  PatientDetails({super.key});

  final PatientDetailsController controller =
      Get.put(PatientDetailsController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: theme.scaffoldBackgroundColor,
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<PatientDetailsController>(
                          builder: (controller) => Row(
                                children: [
                                  Icon(
                                    controller.sex == "Male"
                                        ? Icons.person
                                        : Icons.person_2,
                                    color: controller.sex == "Male"
                                        ? Colors.blue
                                        : Colors.pink,
                                    size: 30,
                                  ),
                                  Text(
                                    controller.name,
                                    style: textTheme.titleMedium,
                                  ),
                                ],
                              )),
                      const SizedBox(height: 10),
                      GetBuilder<PatientDetailsController>(
                          builder: (controller) => Text(
                                controller.phone,
                                style: textTheme.titleSmall,
                              )),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.toNamed("/patientCreate",
                              arguments: {'id': controller.id});
                        },
                        icon: const Icon(
                          Icons.edit_note_rounded,
                          size: 36,
                        ),
                      ),
                      GetBuilder<PatientDetailsController>(
                        builder: (controller) => Text(
                          controller.birthdate,
                          style: textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(color: theme.dividerColor),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Dues: ',
                        style: textTheme.titleSmall,
                      ),
                      GetBuilder<PatientDetailsController>(
                          builder: (controller) => Text(
                                controller.dues,
                                style: textTheme.labelLarge,
                              )),
                      Text(
                        ' SYP',
                        style: textTheme.labelLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildSectionTitle("Visits:", textTheme.titleSmall),
                      IconButton(
                        onPressed: () {
                          // Navigator.pushNamed(
                          //   context,
                          //   "/paymentCreate",
                          //   arguments: {
                          //     'patientId': id,
                          //     'patient_name': name,
                          //     'patient_phone': phone,
                          //     'patient_sex': sex,
                          //   },
                          // );
                        },
                        icon: const Icon(
                          Icons.add_circle_outline_sharp,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  GetBuilder<PatientDetailsController>(
                      builder: (controller) => buildListContainer(
                            theme.colorScheme.surface,
                            controller.visits
                                .map((v) => VisitCard(
                                      v['id'],
                                      v['name'],
                                      double.parse(v['charge'].toString()),
                                      DateTime.parse(v['date']),
                                    ))
                                .toList(),
                          )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildSectionTitle("Payments:", textTheme.titleSmall),
                      IconButton(
                        onPressed: () {
                          Get.toNamed(
                            "/paymentCreate",
                            arguments: {
                              'patientId': controller.id,
                              'patient_name': controller.name,
                              'patient_phone': controller.phone,
                              'patient_sex': controller.sex,
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.monetization_on_outlined,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  GetBuilder<PatientDetailsController>(
                      builder: (controller) => buildListContainer(
                            theme.colorScheme.surface,
                            controller.payments
                                .map((p) => PaymentCard(
                                      p['id'],
                                      controller.name,
                                      p['Doctor']['name'],
                                      double.parse(p['amount'].toString()),
                                      DateTime.parse(p['date']),
                                    ))
                                .toList(),
                          )),
                ],
              ),
              const SizedBox(height: 20),
              GetBuilder<PatientDetailsController>(
                  builder: (controller) => NavBar('patient', controller.id)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title, TextStyle? style) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Text(
        title,
        style: style,
      ),
    );
  }

  Widget buildListContainer(Color backgroundColor, List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.all(10),
      height: 200,
      child: SingleChildScrollView(
        child: Column(children: items),
      ),
    );
  }
}
