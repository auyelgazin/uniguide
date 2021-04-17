import 'package:get/get.dart';
import 'dart:ui';

class LanguageController extends GetxController{

  void changeLanguage(var lang, var region){

    var locale = Locale(lang, region);
    Get.updateLocale(locale);
  }

}