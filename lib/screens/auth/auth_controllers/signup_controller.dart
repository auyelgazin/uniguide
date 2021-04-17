import 'package:get/get.dart';

class SignupController extends GetxController {
  final checkboxValue = false.obs;

  changeValue() {
    checkboxValue.value = !checkboxValue.value;
    update();
  }
}
