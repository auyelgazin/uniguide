import 'package:flutter/material.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:get/get.dart';
import 'package:uniguide/widgets/auth_textfield.dart';
import 'package:uniguide/widgets/wide_button_box.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20),
              child: Text(
                'login'.tr,
                style: titleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'loginInfo'.tr,
                style: loginSignupInfo,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 37,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AuthTextField(
                    hintLabelText: 'emailAddress'.tr,
                    hidePassword: false,
                    controller: emailController,
                    trailingIcon: null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
