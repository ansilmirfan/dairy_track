import 'package:dairy_track/features/presentation/getx/log_in_auth.dart';
import 'package:dairy_track/features/presentation/pages/home.dart';
import 'package:dairy_track/features/presentation/themes/themes.dart';
import 'package:dairy_track/features/presentation/widgets/custom_text_button.dart';
import 'package:dairy_track/features/presentation/widgets/custom_textformfiled.dart';
import 'package:dairy_track/features/presentation/widgets/elevated_container.dart';
import 'package:dairy_track/features/presentation/widgets/gap.dart';
import 'package:dairy_track/features/presentation/widgets/text/bold_title_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginAuthController authController = Get.put(LoginAuthController());

  @override
  Widget build(BuildContext context) {
    var width = Get.mediaQuery.size.width;
    return Scaffold(
      body: Obx(
        () {
          if (authController.isLoggedIn.value) {
            Future.microtask(
              () => Get.off(Home()),
            );
          }
          return Container(
            decoration: Themes.linearGradiantDecoration,
            child: _loginForm(width),
          );
        },
      ),
    );
  }

  Center _loginForm(double width) {
    return Center(
      child: ElevatedContainer(
          child: SizedBox(
        width: width * .9,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BoldTitleText(text: 'Sign In'),
              const Gap(),
              CustomTextFormField(
                controller: userNameController,
                labelText: 'UserName',
              ),
              const Gap(),
              CustomTextFormField(
                controller: passwordController,
                labelText: 'Password',
                password: true,
              ),
              const Gap(),
              Obx(() {
                if (authController.loading.value) {
                  return CustomTextButton(progress: true);
                }
                return CustomTextButton(
                  text: 'Sign In',
                  onPressed: () {
                    authController.login(
                      userNameController.text.trim(),
                      passwordController.text.trim(),
                    );
                  },
                );
              })
            ],
          ),
        ),
      )),
    );
  }
}
