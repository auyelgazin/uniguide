import 'package:get/get.dart';
import 'dart:ui';

class LanguageController extends GetxController{

  var locale;

  void changeLanguage(var lang, var region){

    locale = Locale(lang, region);
    Get.updateLocale(locale);
  }

  Locale getLocale(){
    return locale;
  }

}