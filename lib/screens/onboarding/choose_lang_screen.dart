import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/controllers/language_controller.dart';
import 'package:uniguide/widgets/font_styles.dart';
import 'package:uniguide/widgets/wide_button_box.dart';
import 'welcome_screen.dart';

LanguageController _controller = Get.put(LanguageController());

class ChooseLangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'choose'.tr,
              textAlign: TextAlign.center,
              style: titleStyle,
            ),
          ),
          SizedBox(
            height: 60,
          ),
          WideButtonBox(
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFB7C1F4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('images/en.png'),
                    maxRadius: 15,
                  ),
                  Text(
                    'English',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF141619),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF232195).withOpacity(0.5),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 21,
          ),
          WideButtonBox(
            Container(
              child: LangButton('ru', 'RU', 'Русский'),
            ),
          ),
          SizedBox(
            height: 21,
          ),
          WideButtonBox(
            Container(
              child: LangButton('kz', 'KZ', 'Қазақша'),
            ),
          ),
        ],
      ),
    );
  }
}

class LangButton extends StatelessWidget {
  final String lang;
  final String region;
  final String langName;

  LangButton(this.lang, this.region, this.langName);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Color(0xFFB7C1F4),
      ),
      onPressed: () {
        _controller.changeLanguage(lang, region);
        Get.to(WelcomeScreen());
      },
      child: Text(langName),
    );
  }
}
