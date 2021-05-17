import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/constants/language/language_controller.dart';
import 'package:uniguide/widgets/auth_widgets/auth_checkbox.dart';
import 'package:uniguide/widgets/lang_button.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  LanguageController _languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF232195),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        title: Text(
          'Language',
          style: titleStyle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LangButton(
              langID: 'en',
              region: 'US',
              assetImage: 'images/en.png',
              langName: 'English  ',
              languageController: _languageController,
              getTo: () {
                Get.back();
              }),
          SizedBox(
            height: 21,
          ),
          LangButton(
              langID: 'ru',
              region: 'RU',
              assetImage: 'images/ru.png',
              langName: 'Русский',
              languageController: _languageController,
              getTo: () {
                Get.back();
              }),
          SizedBox(
            height: 21,
          ),
          LangButton(
              langID: 'kz',
              region: 'KZ',
              assetImage: 'images/kz.png',
              langName: 'Қазақша',
              languageController: _languageController,
              getTo: () {
                Get.back();
              }),
        ],
      ),
    );
  }
}
