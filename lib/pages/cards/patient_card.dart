import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientCard extends StatelessWidget {
  final int id;
  final String name;
  final String phone;
  final int sex;

  const PatientCard(this.id, this.name, this.phone, this.sex, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 10),
          IconButton(
              onPressed: () {
                // Navigator.pushNamed(context, "/patientDetails", arguments: id);
                Get.toNamed("/patientDetails", arguments: id);
              },
              icon: const Icon(
                Icons.info_outline,
                size: 26,
              )),
          const SizedBox(width: 7),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 5,
              ),
              Text(
                name,
                style: textTheme.titleSmall,
              ),
              Text(
                phone,
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
              child: Icon(
                sex == 1 ? Icons.person : Icons.person_2,
                color: sex == 1 ? Colors.blue : Colors.pink,
                size: 26,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
