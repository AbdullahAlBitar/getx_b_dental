import 'package:get/get.dart';
import 'package:getx_b_dental/controllers/visit_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:getx_b_dental/pages/cards/nav_bar.dart';
import 'package:getx_b_dental/pages/cards/patient_card.dart';

class VisitDetails extends StatelessWidget {
  VisitDetails({super.key});

  final VisitDetailsController controller = Get.put(VisitDetailsController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.name.value,
                        style: textTheme.titleSmall,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit_note_rounded,
                          size: 36,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  controller.description.value,
                  softWrap: true,
                  style: textTheme.labelSmall,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      controller.date.value.substring(0, 10),
                      softWrap: true,
                      style: textTheme.labelMedium,
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
                          'Dr: ',
                          style: textTheme.titleSmall,
                        ),
                        Text(
                          controller.doctorName.value,
                          style: textTheme.labelLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Charge: ',
                          style: textTheme.titleSmall,
                        ),
                        Text(
                          controller.charge.value,
                          style: textTheme.labelLarge,
                        ),
                        Text(
                          ' SYP',
                          style: textTheme.labelLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    PatientCard(
                      controller.patientId.value,
                      controller.patientName.value,
                      controller.patientPhone.value,
                      controller.patientSex.value == "Male" ? 1 : 0,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                NavBar('visit', controller.id.value),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
