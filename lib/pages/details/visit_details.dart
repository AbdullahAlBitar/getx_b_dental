import 'package:get/get.dart';
import 'package:getx_b_dental/controllers/visit_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:getx_b_dental/pages/cards/image_card.dart';
import 'package:getx_b_dental/pages/widgets/card_scroller.dart';
import 'package:getx_b_dental/pages/widgets/nav_bar.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<VisitDetailsController>(
                        builder: (controller) => Text(
                              controller.name,
                              style: textTheme.titleSmall,
                            )),
                    IconButton(
                      onPressed: () {
                        Get.toNamed("/visitCreate", arguments: {
                          'id': controller.id,
                          'patientId': controller.patientId
                        });
                      },
                      icon: const Icon(
                        Icons.edit_note_rounded,
                        size: 36,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              GetBuilder<VisitDetailsController>(
                  builder: (controller) => Text(
                        controller.description,
                        softWrap: true,
                        style: textTheme.labelSmall,
                      )),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildSectionTitle("CasePhotos:", textTheme.titleSmall),
                  IconButton(
                    onPressed: () {
                      controller.uploadCasePhoto();
                    },
                    icon: const Icon(
                      Icons.add_circle_outline_sharp,
                      size: 30,
                    ),
                  )
                ],
              ),
              GetBuilder<VisitDetailsController>(
                      builder: (controller) => CardScroller(
                height: 260,
                scrollDirection: Axis.horizontal,
                children: controller.casePhotos
                    .map((cp) =>
                        ImageCard( id: cp['id'],date: cp['date'], imageUrl: cp['imageUrl'], type: cp['type'],))
                    .toList(),
              )),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GetBuilder<VisitDetailsController>(
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
                    children: [
                      Text(
                        'Dr: ',
                        style: textTheme.titleSmall,
                      ),
                      GetBuilder<VisitDetailsController>(
                          builder: (controller) => Text(
                                controller.doctorName,
                                style: textTheme.labelLarge,
                              )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Charge: ',
                        style: textTheme.titleSmall,
                      ),
                      GetBuilder<VisitDetailsController>(
                          builder: (controller) => Text(
                                controller.charge,
                                style: textTheme.labelLarge,
                              )),
                      Text(
                        ' SYP',
                        style: textTheme.labelLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GetBuilder<VisitDetailsController>(
                      builder: (controller) => PatientCard(
                            controller.patientId,
                            controller.patientName,
                            controller.patientPhone,
                            controller.patientSex == "Male" ? 1 : 0,
                          )),
                  const SizedBox(height: 20),
                ],
              ),
              GetBuilder<VisitDetailsController>(
                  builder: (controller) => NavBar('visit', controller.id)),
            ],
          ),
        ),
      ),
    );
  }
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
