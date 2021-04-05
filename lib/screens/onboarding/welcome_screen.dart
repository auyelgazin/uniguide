import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/widgets/auth_button.dart';
import 'package:uniguide/widgets/font_styles.dart';
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
                // TODO
                // SizedBox(
                //   height: 15,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'welcome_info'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF161616),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  WideButtonBox(
                    Container(
                      child: AuthButton(
                        'login'.tr,
                        () {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'no_acc'.tr,
                          style: TextStyle(
                            color: Color(0xFF161616),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        TextButton(
                          child: Text(
                            'signup'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(0xFF4F4DAA),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: () {
                            print('pressed');
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
