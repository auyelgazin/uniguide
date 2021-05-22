import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/constants/language/languages.dart';
import 'package:uniguide/provider_files/post_functions.dart';
import 'package:uniguide/provider_files/survey_functions.dart';
import 'package:uniguide/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_provider.dart';
import 'package:uniguide/screens/dashboard/dashboard_helper.dart';
import 'package:uniguide/screens/dashboard/profile_screens/profile_helper.dart';

import 'package:provider/provider.dart';

import 'provider_files/authentication.dart';
import 'provider_files/firebase_operations.dart';

int initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase Core initialization
  await Firebase.initializeApp();

  // SharedPreferences - for storing data in a file on the device
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: GetMaterialApp(
        // Localization based properties:
        locale: Locale('en', 'US'),
        fallbackLocale: Locale('en', 'US'),
        translations: Languages(),

        title: 'UniGuide',
        theme: ThemeData(
          fontFamily: 'SFPro',
          primarySwatch: Colors.blue,
          unselectedWidgetColor: Color(0xFF232195),
        ),
        debugShowCheckedModeBanner: false,
        getPages: AppRoutes.list,
        initialRoute: initScreen == 0 || initScreen == null
            ? '/chooseLang'
            : '/chooseLang'
            // : authWrap(context),
      ),
      providers: [
        ChangeNotifierProvider(create: (_) => SurveyFunctions()),
        ChangeNotifierProvider(create: (_) => PostFunctions()),
        ChangeNotifierProvider(create: (_) => FirebaseOperations()),
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => DashboardHelper()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => ProfileHelper()),
      ],
    );
  }
}

String authWrap(BuildContext context) {
  if (FirebaseAuth.instance.currentUser != null) {
    // Provider.of<FirebaseOperations>(context, listen: false).initUserData(context);
    //  FirebaseOperations().initUserData(context);
    return '/dashboard';
  } else
    return '/login';
}
