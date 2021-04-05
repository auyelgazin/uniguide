import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){Get.back();}),
              ],
            ),
            Container(
              child: Image(
                image: AssetImage('images/welcome_screen.png'),
              ),
            ),
            Text(
              'welcome'.tr,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Color(0xFF232195),
              ),
            ),
            Text(
              'welcome_info'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xFF161616),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: 335, height: 57),
                    child: ElevatedButton(
                      child: Text('Войти'),
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF4F4DAA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'У вас еще нет аккаунта? ',
                        style: TextStyle(
                          color: Color(0xFF161616),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      TextButton(
                        child: Text(
                          'Зарегистрироваться',
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
