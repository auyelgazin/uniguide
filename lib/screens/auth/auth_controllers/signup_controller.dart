import 'package:get/get.dart';
import 'package:uniguide/screens/auth/auth_models/position.dart';

class SignupController extends GetxController {
  final checkboxValue = false.obs;
  final chosenPosition = ''.obs;

  final positions = [
    Position(title: 'Student'),
    Position(title: 'Teacher'),
    Position(title: 'Stuff'),
  ];

  changeValue() {
    checkboxValue.value = !checkboxValue.value;
    update();
  }

}
