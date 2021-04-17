import 'package:get/get.dart';


class SignupController extends GetxController {

  final error = ''.obs;

  emptyAgain() => error.value = '';
  notAllFieldsFilled() => error.value = 'Fill all the fields';
  useSDUmail() => error.value = 'Use your SDU email';
  acceptAgreement() => error.value = 'Tick agreement';
  passwordLessThanSix() => error.value = 'Password must contain at least 6 characters';

}
