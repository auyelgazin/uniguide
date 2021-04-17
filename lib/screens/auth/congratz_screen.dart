import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CongratzScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.offNamed('/dashboard');
      },
      child: Scaffold(
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  child: Image(
                    image: AssetImage('images/tick.png'),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Text(
                    'Поздравляю! Вы успешно зарегались',
                    style: TextStyle(
                        color: Color(0xFF141619),
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
