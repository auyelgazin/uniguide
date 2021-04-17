import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/constants/language/languages.dart';
import 'package:uniguide/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniguide/screens/onboarding/choose_lang_screen.dart';
import 'package:uniguide/services/auth_service.dart';

int initScreen;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Firebase Core initialization
  await Firebase.initializeApp();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      // Localization based properties:
      locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
      translations: Languages(),

      title: 'UniGuide',
      theme: ThemeData(
        fontFamily: 'SFPro',
        primarySwatch: Colors.blue,
      ),
      getPages: AppRoutes.list,
      initialRoute: initScreen == 0 || initScreen == null ? '/chooseLang' : '/signup',
      // home: initScreen == 0 || initScreen == null ? ChooseLangScreen() : LoginScreen(),
      
    );
  }
}

// String authoredOrNot(){
//   if()
// }
