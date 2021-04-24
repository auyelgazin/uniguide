
import 'package:get_it/get_it.dart';
import 'package:uniguide/screens/dashboard/controllers/user_controller.dart';

final locator  = GetIt.instance;

void setupServices() {
  locator.registerSingleton<UserController>(UserController());
}