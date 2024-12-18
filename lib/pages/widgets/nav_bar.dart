import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/controllers/delete_controller.dart';

class NavBar extends StatelessWidget {
  final String type;
  final int id;

  NavBar(this.type, this.id, {super.key});
  final DeleteController controller = Get.find();
  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 5, color: theme.colorScheme.secondary),
                    borderRadius: BorderRadius.circular(8),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        size: 36,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.offNamedUntil("/home", (route) => route.settings.name == '/');
                      },
                      icon: const Icon(
                        Icons.home,
                        size: 36,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.deleteItem(id, type);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 36,
                      ),
                    ),
                  ],
                ),
              );
  }
}
