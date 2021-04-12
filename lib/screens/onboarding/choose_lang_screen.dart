import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/controllers/language_controller.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/widgets/lang_button.dart';

LanguageController _controller = Get.put(LanguageController());

class ChooseLangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40, top: 130),
              child: Text(
                'choose'.tr,
                textAlign: TextAlign.center,
                style: titleStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
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
          ),
          Spacer(),
        ],
      ),
    );
  }
}
