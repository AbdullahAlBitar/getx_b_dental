import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentCard extends StatelessWidget {
  final int id;
  final String patientName;
  final String doctorName;
  final double amount;
  final DateTime date;

  const PaymentCard(this.id, this.patientName, this.doctorName, this.amount, this.date, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 5),
          IconButton(
              onPressed: () {
                    // Navigator.pushNamed(context, "/paymentDetails", arguments: id);
                    Get.toNamed("/paymentDetails", arguments: id);
              },
              icon: const Icon(
                Icons.info_outline,
                size: 26,
              )),
          const SizedBox(width: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 5,),
              Row(
                children: [
                  Text(
                    patientName,
                    style: textTheme.labelMedium,
                  ),
                  Icon(
                    Icons.double_arrow_outlined,
                    size: 15,
                    color: theme.dividerColor,
                  ),
                  Text(
                    doctorName,
                    style: textTheme.labelMedium,
                  ),
                ],
              ),
              Text(
                "${amount.toString().substring(0, amount.toString().indexOf("."))} SYP",
                style: textTheme.labelSmall,
              ),
              const SizedBox(height: 10)
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  date.toString().substring(0, 10),
                  style: textTheme.labelSmall,
                )),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
