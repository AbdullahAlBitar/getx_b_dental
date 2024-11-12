import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/controllers/auth_controller.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "B-Dental",
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 40),
            TextField(
              style: textTheme.labelMedium,
              controller: controller.phoneTextCont,
              decoration: const InputDecoration(
                hintText: "Phone",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              style: textTheme.labelMedium,
              controller: controller.passwordTextCont,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.toNamed("/signup");
                  },
                  child: Text("Sign Up?",
                  style: textTheme.labelMedium,
                  ),
                ),
                Obx(() => ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () async {
                              await controller.login();
                            },
                      child: controller.isLoading.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text("Login",
                          style: textTheme.labelMedium,
                          ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
