import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/controllers/payment_conrtoller.dart';
import 'package:getx_b_dental/pages/cards/payment_card.dart';

class Payment extends StatelessWidget {
  Payment({super.key});

  final PaymentController controller = Get.find();

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
            Get.toNamed("/paymentUpdate");
          },
          icon: const Icon(
            Icons.attach_money,
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
                    'Payments: ',
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
                child: GetBuilder<PaymentController>(
                    builder: (controller) => SingleChildScrollView(
                          child: Column(
                            children: controller.payments
                                .map((p) => PaymentCard(
                                      p['id'],
                                      p['patient']['name'],
                                      p['Doctor']['name'],
                                      double.parse(p['amount'].toString()),
                                      DateTime.parse(p['date']),
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
