import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/controllers/language_controller.dart';
import 'package:uniguide/widgets/font_styles.dart';
import 'package:uniguide/widgets/wide_button_box.dart';
import 'welcome_screen.dart';
import 'package:uniguide/widgets/lang_button.dart';

LanguageController _controller = Get.put(LanguageController());

class ChooseLangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              'choose'.tr,
              textAlign: TextAlign.center,
              style: titleStyle,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Column(
            children: [
              LangButton(
                langID: 'en',
                region: 'US',
                assetImage: 'images/en.png',
                langName: 'English  ',
                languageController: _controller,
              ),
              SizedBox(
                height: 21,
              ),
              LangButton(
                langID: 'ru',
                region: 'RU',
                assetImage: 'images/ru.png',
                langName: 'Русский',
                languageController: _controller,
              ),
              SizedBox(
                height: 21,
              ),
              LangButton(
                langID: 'kz',
                region: 'KZ',
                assetImage: 'images/kz.png',
                langName: 'Қазақша',
                languageController: _controller,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
