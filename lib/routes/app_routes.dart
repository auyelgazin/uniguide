import 'package:get/get.dart';
import 'package:uniguide/screens/auth/congratz_screen.dart';
import 'package:uniguide/screens/auth/login_screen.dart';
import 'package:uniguide/screens/auth/signup_screen.dart';
import 'package:uniguide/screens/dashboard/chat_screen.dart';
import 'package:uniguide/screens/dashboard/profile_screens/profile_screen.dart';
import 'package:uniguide/screens/dashboard/profile_screens/persontal_data_screen.dart';
import 'package:uniguide/screens/dashboard/profile_screens/settings_screen.dart';
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
    ),
    GetPage(
      name: '/profile',
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: '/profileEdit',
      page: () => PersonalDataScreen(),
    ),
    GetPage(
      name: '/settings',
      page: () => SettingsScreen(),
    ),
    GetPage(
      name: '/chat',
      page: () => ChatScreen(),
    ),
  ];
}
