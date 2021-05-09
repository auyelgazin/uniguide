import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/constants/language/languages.dart';
import 'package:uniguide/provider_files/post_functions.dart';
import 'package:uniguide/provider_files/upload_post.dart';
import 'package:uniguide/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_provider.dart';
import 'package:uniguide/screens/dashboard/dashboard_helper.dart';
import 'package:uniguide/screens/dashboard/profile_screens/profile_helper.dart';
import 'package:uniguide/screens/onboarding/choose_lang_screen.dart';
import 'package:uniguide/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'provider_files/authentication.dart';
import 'provider_files/firebase_operations.dart';

import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';



int initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  // Firebase Core initialization
  await Firebase.initializeApp();

  // SharedPreferences - for storing data in a file on the device
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
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
        getPages: AppRoutes.list,
        initialRoute:
            initScreen == 0 || initScreen == null ? '/chooseLang' : authWrap(),
      ),
      providers: [
        ChangeNotifierProvider(create: (_) => PostFunctions()),
        ChangeNotifierProvider(create: (_) => UploadPost()),
        ChangeNotifierProvider(create: (_) => FirebaseOperations()),
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => DashboardHelper()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => ProfileHelper()),
      ],
    );
  }
}

String authWrap() {
  if (FirebaseAuth.instance.currentUser != null) {
    return '/dashboard';
  } else
    return '/login';
}
