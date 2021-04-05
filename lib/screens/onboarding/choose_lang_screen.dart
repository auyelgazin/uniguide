import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/controllers/language_controller.dart';
import 'welcome_screen.dart';

LanguageController _controller = Get.put(LanguageController());

class ChooseLangScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('choose'.tr),
            LangButton('en', 'US', 'English'),
            LangButton('ru', 'RU', 'Русский'),
            LangButton('kz', 'KZ', 'Қазақша'),
            
          ],
        ),
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
      onPressed: () {
        _controller.changeLanguage(lang, region);
        Get.to(WelcomeScreen());
      },
      child: Text(langName),
    );
  }
}

