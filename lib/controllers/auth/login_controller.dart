import 'package:get/get.dart';
class LoginController extends GetxController{

  final error = ''.obs;

  isIncorrect() => error.value = 'Email or password incorrect';
}