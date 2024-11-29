import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_b_dental/controllers/auth_controller.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final AuthController controller = Get.put(AuthController());
  final FocusNode phoneFocus = FocusNode(); // FocusNode for the phone field
  final FocusNode passwordFocus = FocusNode(); // FocusNode for the password field

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
            // Phone TextField
            TextField(
              keyboardType: TextInputType.number,
              style: textTheme.labelMedium,
              controller: controller.phoneTextCont,
              focusNode: phoneFocus,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: "Phone",
              ),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(passwordFocus);
              },
            ),
            const SizedBox(height: 20),
            // Password TextField
            TextField(
              style: textTheme.labelMedium,
              controller: controller.passwordTextCont,
              focusNode: passwordFocus,
              obscureText: true,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
              onSubmitted: (_) async {
                await controller.login(); // Trigger login on "Done"
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.toNamed("/signup");
                  },
                  child: Text(
                    "Sign Up?",
                    style: textTheme.labelMedium,
                  ),
                ),
                GetBuilder<AuthController>(
                    builder: (controller) => ElevatedButton(
                          onPressed: controller.isLoading
                              ? null
                              : () async {
                                  await controller.login();
                                },
                          child: controller.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  "Login",
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
