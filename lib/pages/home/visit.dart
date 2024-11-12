import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/controllers/visit_controller.dart';
import 'package:getx_b_dental/pages/cards/visit_card.dart';

class Visit extends StatelessWidget {
  Visit({super.key});

  final VisitController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    
    return Scaffold(
      floatingActionButton: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle, color: theme.colorScheme.primary
        ),
        child: IconButton(
          onPressed: () {
            // Add navigation to create a new visit
          },
          icon: const Icon(
            Icons.add_circle_outline_sharp,
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
                    'Visits: ',
                    style: textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height - 50 - 120,
                child: Obx(() => SingleChildScrollView(
                  child: Column(
                    children: controller.visits
                        .map((v) => VisitCard(
                              v['id'],
                              v['name'],
                              double.parse(v['charge'].toString()),
                              DateTime.parse(v['date']),
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
