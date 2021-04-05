import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/widgets/auth_button.dart';
import 'package:uniguide/widgets/font_styles.dart';

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
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    Get.back();
                  },
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
                Text(
                  'welcome'.tr,
                  style: titleStyle,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
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
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: 335, height: 57),
                    child: Container(
                      child: AuthButton(
                        'login'.tr,
                        () {},
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
