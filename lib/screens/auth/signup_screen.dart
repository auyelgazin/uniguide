import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:get/get.dart';
import 'package:uniguide/screens/auth/auth_controllers/signup_controller.dart';
import 'package:uniguide/screens/auth/auth_models/position.dart';
import 'package:uniguide/services/auth_service.dart';
import 'package:uniguide/widgets/auth_widgets/auth_button.dart';
import 'package:uniguide/widgets/auth_widgets/auth_checkbox.dart';
import 'package:uniguide/widgets/auth_widgets/auth_textfield.dart';
import 'package:uniguide/widgets/wide_button_box.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SignupController controller = Get.put(SignupController());

  String chosenPosition;
  bool agreement = false;

  final positions = [
    Position(title: 'Student'),
    Position(title: 'Teacher'),
    Position(title: 'Stuff'),
  ];

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Choose your position:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF141619),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFB7C1F4).withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFB7C1F4).withOpacity(0.4),
                      ),
                      child: Column(
                        children: [
                          buildSingleCheckbox(positions[0], () {
                            setState(() {
                              positions[1].value = false;
                              positions[2].value = false;

                              final newValue = !positions[0].value;
                              positions[0].value = newValue;

                              if (positions[0].value == true) {
                                chosenPosition = positions[0].title;
                              } else {
                                chosenPosition = null;
                              }
                              print(chosenPosition);
                            });
                          }),
                          buildSingleCheckbox(positions[1], () {
                            setState(() {
                              positions[0].value = false;
                              positions[2].value = false;

                              final newValue = !positions[1].value;
                              positions[1].value = newValue;

                              if (positions[1].value == true) {
                                chosenPosition = positions[1].title;
                              } else {
                                chosenPosition = null;
                              }
                              print(chosenPosition);
                            });
                          }),
                          buildSingleCheckbox(positions[2], () {
                            setState(() {
                              positions[1].value = false;
                              positions[0].value = false;

                              final newValue = !positions[2].value;
                              positions[2].value = newValue;

                              if (positions[2].value == true) {
                                chosenPosition = positions[2].title;
                              } else {
                                chosenPosition = null;
                              }
                              print(chosenPosition);
                            });
                          }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          tristate: false,
                          activeColor: Color(0xFF232195),
                          value: agreement,
                          onChanged: (value) {
                            setState(() {
                              agreement = value;
                            });
                          },
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Я даю согласие на обработку персональных данных',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  WideButtonBox(
                    AuthButton(
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
