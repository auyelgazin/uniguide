import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/widgets/auth_widgets/auth_button.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/widgets/wide_button_box.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFF232195).withOpacity(0.3),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
            Container(
              child: Image(
                height: 300,
                image: AssetImage('images/welcome_screen.png'),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text(
                    'welcome'.tr,
                    textAlign: TextAlign.center,
                    style: titleStyle,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'welcome_info'.tr,
                    textAlign: TextAlign.center,
                    style: welcomeInfo,
                  ),
                ),
              ],
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WideButtonBox(
                    Container(
                      child: AuthButton(
                        'signup'.tr,
                        () {
                          Get.offNamed('/signup');
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'have_acc?'.tr,
                          style: dontHaveAnAccount,
                        ),
                        TextButton(
                          child: Text(
                            'login'.tr,
                            style: smallLogin,
                          ),
                          onPressed: () {
                            Get.offNamed('/login');
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
