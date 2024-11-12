
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitCard extends StatelessWidget {
  final int id;
  final String name;
  final double charge;
  final DateTime date;

  const VisitCard(this.id, this.name, this.charge, this.date, {super.key});

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
                    // Navigator.pushNamed(context, "/visitDetails", arguments: id);
                    Get.toNamed("/visitDetails", arguments: id);
              },
              icon: const Icon(
                Icons.info_outline,
                size: 26,
              )),
          const SizedBox(width: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 5,),
              Text(
                name,
                style: textTheme.titleSmall,
              ),
              Text(
                "${charge.toString().substring(0, charge.toString().indexOf("."))} SYP",
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
