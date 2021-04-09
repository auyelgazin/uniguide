import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:get/get.dart';
import 'package:uniguide/services/auth_service.dart';
import 'package:uniguide/widgets/auth_button.dart';
import 'package:uniguide/widgets/auth_textfield.dart';
import 'package:uniguide/widgets/wide_button_box.dart';

class SignupScreen extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final TextEditingController fullNameController = TextEditingController();
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
                'signup'.tr,
                style: titleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'signup_info'.tr,
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
                    hintLabelText: 'full_name'.tr,
                    hidePassword: false,
                    controller: fullNameController,
                    trailingIcon: null,
                    keyboardType: TextInputType.name,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AuthTextField(
                    hintLabelText: 'email_address'.tr,
                    hidePassword: false,
                    controller: emailController,
                    trailingIcon: null,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AuthTextField(
                    hintLabelText: 'password'.tr,
                    hidePassword: true,
                    controller: passwordController,
                    trailingIcon: Icon(Icons.remove_red_eye),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                WideButtonBox(
                  DropdownButton()
                ),
                SizedBox(
                  height: 37,
                ),
                WideButtonBox(
                  Container(
                    child: AuthButton(
                      'signup'.tr,
                      () async {
                        String res =
                            await AuthService(auth: firebaseAuth).Signup(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        print(res);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(
                        'have_acc?'.tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF141619),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offNamed('/login');
                        },
                        child: Text(
                          'login'.tr,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF4F4DAA),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
