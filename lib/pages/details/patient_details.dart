import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/controllers/patient_details_controller.dart';
import 'package:getx_b_dental/pages/cards/nav_bar.dart';
import 'package:getx_b_dental/pages/cards/payment_card.dart';
import 'package:getx_b_dental/pages/cards/visit_card.dart';

class PatientDetails extends StatelessWidget {
  PatientDetails({super.key});

  final PatientDetailsController controller = Get.put(PatientDetailsController());

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
                      Obx(() => Row(
                        children: [
                          Icon(
                            controller.sex.value == "Male" ? Icons.person : Icons.person_2,
                            color: controller.sex.value == "Male" ? Colors.blue : Colors.pink,
                            size: 30,
                          ),
                          Text(
                            controller.name.value,
                            style: textTheme.titleMedium,
                          ),
                        ],
                      )),
                      const SizedBox(height: 10),
                      Obx(() => Text(
                        controller.phone.value,
                        style: textTheme.titleSmall,
                      )),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Get.toNamed("/patientUpdate", arguments: {'id': controller.id.value});
                    },
                    icon: const Icon(
                      Icons.edit_note_rounded,
                      size: 36,
                    ),
                  ),
                ],
              ),
              Divider(color: theme.dividerColor),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Row(
                    children: [
                      Text(
                        'Dues: ',
                        style: textTheme.titleSmall,
                      ),
                      Text(
                        controller.dues.value,
                        style: textTheme.labelLarge,
                      ),
                      Text(
                        ' SYP',
                        style: textTheme.labelLarge,
                      ),
                    ],
                  )),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildSectionTitle("Visits:", textTheme.titleSmall),
                      IconButton(
                        onPressed: () {
                          // Navigator.pushNamed(
                          //   context,
                          //   "/paymentUpdate",
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
                  buildListContainer(
                    theme.colorScheme.surface,
                    controller.visits.map((v) => VisitCard(
                      v['id'],
                      v['name'],
                      double.parse(v['charge'].toString()),
                      DateTime.parse(v['date']),
                    )).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildSectionTitle("Payments:" , textTheme.titleSmall),
                      IconButton(
                        onPressed: () {
                          // Navigator.pushNamed(
                          //   context,
                          //   "/paymentUpdate",
                          //   arguments: {
                          //     'patientId': id,
                          //     'patient_name': name,
                          //     'patient_phone': phone,
                          //     'patient_sex': sex,
                          //   },
                          // );
                        },
                        icon: const Icon(
                          Icons.monetization_on_outlined,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  buildListContainer(
                    theme.colorScheme.surface,
                    controller.payments.map((p) => PaymentCard(
                      p['id'],
                      controller.name.value,
                      p['Doctor']['name'],
                      double.parse(p['amount'].toString()),
                      DateTime.parse(p['date']),
                    )).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              NavBar('patient', controller.id.value),
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
