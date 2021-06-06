import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:get/get.dart';
import 'package:uniguide/provider_files/authentication.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/screens/auth/auth_controllers/login_controller.dart';
import 'package:uniguide/widgets/auth_widgets/auth_button.dart';
import 'package:uniguide/widgets/auth_widgets/auth_textfield.dart';
import 'package:uniguide/widgets/wide_button_box.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                  'login_info'.tr,
                  style: loginSignupInfo,
                ),
              ),
              SizedBox(
                height: 37,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Obx(
                  () => Text(
                    '${_controller.error.value}',
                    style: authError,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AuthTextField(
                      labelText: 'email_address'.tr,
                      hidePassword: false,
                      controller: _emailController,
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
                      labelText: 'password'.tr,
                      hidePassword: true,
                      controller: _passwordController,
                      trailingIcon: Icon(Icons.remove_red_eye),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'forgot_pass?'.tr,
                          style: TextStyle(
                            color: Color(0xFF4F4DAA),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 37,
                  ),
                  WideButtonBox(
                    AuthButton(
                      'login'.tr,
                      () async {
                        try {
                          await Provider.of<Authentication>(context, listen: false)
                              .logIntoAccount(_emailController.text,
                                  _passwordController.text)
                              .whenComplete(() {
                            print('User logged in');
                            // - - - ->
                            // Provider.of<FirebaseOperations>(context, listen: false).initUserData(context);
                          });
                          Get.toNamed('/dashboard');
                        } catch (e) {
                          _controller.isIncorrect();
                          print(e);
                        }
                        // await AuthService(auth: firebaseAuth).Login(
                        //     email: emailController.text,
                        //     password: passwordController.text);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Text(
                          'no_acc?'.tr,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF141619),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offNamed('/signup');
                          },
                          child: Text(
                            'signup'.tr,
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
      ),
    );
  }
}
