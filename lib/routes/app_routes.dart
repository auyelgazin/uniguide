import 'package:get/get.dart';
import 'package:uniguide/bindings/dashboard_binding.dart';
import 'package:uniguide/screens/auth/congratz_screen.dart';
import 'package:uniguide/screens/auth/login_screen.dart';
import 'package:uniguide/screens/auth/signup_screen.dart';
import 'package:uniguide/screens/onboarding/choose_lang_screen.dart';
import 'package:uniguide/screens/onboarding/welcome_screen.dart';
import 'package:uniguide/screens/dashboard/dashboard_screen.dart';

class AppRoutes {
  static var list = [
    GetPage(
      name: '/chooseLang',
      page: () => ChooseLangScreen(),
    ),
    GetPage(
      name: '/welcome',
      page: () => WelcomeScreen(),
    ),
    GetPage(
      name: '/signup',
      page: () => SignupScreen(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
    ),
    GetPage(
      name: '/congratz',
      page: () => CongratzScreen(),
    ),
    GetPage(
      name: '/dashboard',
      page: () => DashboardScreen(),
      binding: DashboardBinding(),
    ),
  ];
}
