import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/controllers/doctor_controller.dart';
import 'package:getx_b_dental/pages/cards/visit_card.dart';

class Doctor extends StatelessWidget {
  Doctor({super.key});

  final DoctorController controller = Get.find();

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dr. ',
                            style: textTheme.titleSmall,
                          ),
                          GetBuilder<DoctorController>(
                              builder: (controller) => Text(
                                    controller.name,
                                    style: textTheme.titleMedium,
                                  )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      GetBuilder<DoctorController>(
                          builder: (controller) => Text(
                                controller.phone,
                                style: textTheme.titleSmall,
                              )),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit_note_rounded,
                      size: 36,
                    ),
                  )
                ],
              ),
              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Dues: ',
                        style: textTheme.titleSmall,
                      ),
                      GetBuilder<DoctorController>(
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
                  Text(
                    'Visits: ',
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(10),
                    height: 200,
                    child: GetBuilder<DoctorController>(
                        builder: (controller) => SingleChildScrollView(
                              child: Column(
                                children: controller.visits
                                    .map((v) => VisitCard(
                                        v['id'],
                                        v['name'],
                                        double.parse(v['charge'].toString()),
                                        DateTime.parse(v['date'])))
                                    .toList(),
                              ),
                            )),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: controller.logOut,
                    icon: const Icon(
                      Icons.logout_outlined,
                      color: Colors.red,
                      size: 36,
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
