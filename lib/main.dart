import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/constants/lang/languages.dart';
import 'package:uniguide/screens/auth/login_screen.dart';
import 'package:uniguide/screens/onboarding/choose_lang_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
      translations: Languages(),
      title: 'UniGuide',
      theme: ThemeData(
        fontFamily: 'SFPro',
        primarySwatch: Colors.blue,
      ),

      home: LoginScreen(),
      
    );
  }
}
