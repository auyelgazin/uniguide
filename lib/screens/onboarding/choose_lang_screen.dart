import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/controllers/language_controller.dart';
import 'package:uniguide/widgets/font_styles.dart';
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
          LangButton('en', 'US', 'English'),
          LangButton('ru', 'RU', 'Русский'),
          LangButton('kz', 'KZ', 'Қазақша'),
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
