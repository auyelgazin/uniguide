import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:get/get.dart';
import 'package:uniguide/provider_files/authentication.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/screens/auth/auth_controllers/signup_controller.dart';
import 'package:uniguide/screens/auth/auth_models/position.dart';
import 'package:uniguide/services/auth_service.dart';
import 'package:uniguide/services/firestore_service.dart';
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
  bool checkboxMarked = false;
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
              SizedBox(
                height: 37,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Obx(
                  () => Text(
                    '${controller.error.value}',
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
                      labelText: 'full_name'.tr,
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
                      labelText: 'email_address'.tr,
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
                      labelText: 'password'.tr,
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
                      child: Text(
                        'Choose your position:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF141619),
                        ),
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
                                checkboxMarked = true;
                              } else {
                                chosenPosition = null;
                                checkboxMarked = false;
                              }
                              print('chosen position is: $chosenPosition');
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
                                checkboxMarked = true;
                              } else {
                                chosenPosition = null;
                                checkboxMarked = false;
                              }
                              print('chosen position is: $chosenPosition');
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
                                checkboxMarked = true;
                              } else {
                                chosenPosition = null;
                                checkboxMarked = false;
                              }
                              print('chosen position is: $chosenPosition');
                            });
                          }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  PrivacyPolicyCheckbox(
                    agreementValue: agreement,
                    onChanged: (value) {
                      setState(() {
                        agreement = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  WideButtonBox(
                    AuthButton(
                      'signup'.tr,
                      () async {
                        String email = emailController.text.trim();
                        String fullName = fullNameController.text.trim();
                        String password = passwordController.text.trim();

                        if (fullName.isNotEmpty &&
                            password.isNotEmpty &&
                            email.isNotEmpty &&
                            checkboxMarked == true &&
                            agreement == true) {
                          if (chosenPosition == positions[0].title) {
                            // Student
                            if (email.length == 24 &&
                                email.endsWith('@stu.sdu.edu.kz')) {
                              controller.emptyAgain();

                              print('authed stud');
                              // await AuthService(auth: firebaseAuth).Signup(
                              //   email: emailController.text,
                              //   password: passwordController.text,
                              //   fullName: fullName,
                              //   position: chosenPosition,
                              //   avatar: '',
                              // );
                              Provider.of<Authentication>(context, listen: false).createAccount(email, password).whenComplete(() {
                                print('creating USER collection');
                                Provider.of<FirebaseOperations>(context, listen: false).createUserCollection(context, {
                                  'useruid': Provider.of<Authentication>(context, listen: false).getUserUid,
                                  'email': email,
                                  'fullname': fullName,
                                  'position': chosenPosition,
                                });
                              }).whenComplete(() {
                                Get.toNamed('/dashboard');
                              });
                            } else {
                              controller.useSDUmail();
                              
                            }
                          } else {
                            if (!email.endsWith('@sdu.edu.kz')) {
                              controller.useSDUmail();
                            } else {
                              controller.emptyAgain();

                              print('authed teacher & stuff');
                                // await AuthService(auth: firebaseAuth).Signup(
                                //   email: emailController.text,
                                //   password: passwordController.text,
                                //   fullName: fullName,
                                //   position: chosenPosition,
                                //   avatar: '',
                                // );
                                Provider.of<Authentication>(context, listen: false).createAccount(email, password).whenComplete(() {
                                  print('creating USER collection');
                                Provider.of<FirebaseOperations>(context, listen: false).createUserCollection(context, {
                                  'useruid': Provider.of<Authentication>(context, listen: false).getUserUid,
                                  'email': email,
                                  'fullname': fullName,
                                  'position': chosenPosition,
                                });
                              }).whenComplete(() {
                                Get.toNamed('/dashboard');
                              });
                            }
                          }
                        } else {
                          controller.notAllFieldsFilled();
                        }

                        // if (email.endsWith('@sdu.edu.kz') |
                        //     email.endsWith('@stu.sdu.edu.kz')) {
                        //   controller.emptyAgain();

                        //   if (fullName.isNotEmpty &
                        //           password.isNotEmpty &
                        //           checkboxMarked !=
                        //       false) {
                        //     if (agreement != false) {
                        //       // ideal
                        //       controller.emptyAgain();

                        //       await AuthService(auth: firebaseAuth).Signup(
                        //         email: emailController.text,
                        //         password: passwordController.text,
                        //         fullName: fullName,
                        //         position: chosenPosition,
                        //       );
                        //     } else {
                        //       controller.acceptAgreement();
                        //     }
                        //   } else {
                        //     controller.notAllFieldsFilled();
                        //   }
                        // } else {
                        //   controller.useSDUmail();
                        // }
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
                  SizedBox(height: 50)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
