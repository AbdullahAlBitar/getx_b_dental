import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/controllers/patient_controller.dart';
import 'package:getx_b_dental/pages/cards/patient_card.dart';

class Patient extends StatelessWidget {
  Patient({super.key});

  final PatientController controller = Get.find();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      floatingActionButton: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: theme.colorScheme.primary),
        child: IconButton(
          onPressed: () {
            Get.toNamed("/patientCreate");
          },
          icon: const Icon(
            Icons.person_add_alt_outlined,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Patients: ',
                    style: textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Search bar
              TextField(
                style: textTheme.labelMedium,
                controller: searchController,
                onChanged: (value) {
                  controller.filterPatients(value);
                },
                decoration: InputDecoration(
                  labelText: 'Search by name or phone',
                  labelStyle: textTheme.labelMedium,
                  prefixIcon: Icon(
                    Icons.search,
                    color: theme.colorScheme.secondary,
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: theme.colorScheme.secondary)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height - 50 - 170,
                child: GetBuilder<PatientController>(
                    builder: (controller) => SingleChildScrollView(
                          child: Column(
                            children: controller.filteredPatients
                                .map((p) => PatientCard(
                                      p['id'],
                                      p['name'],
                                      p['phone'],
                                      p['sex'] == "Male" ? 1 : 0,
                                    ))
                                .toList(),
                          ),
                        )),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
