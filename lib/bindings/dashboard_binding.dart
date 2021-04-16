import 'package:get/get.dart';
import 'package:uniguide/controllers/dashboard/dashboard_controller.dart';
import 'package:uniguide/screens/dashboard/models/blog_model.dart';
import 'package:uniguide/screens/dashboard/models/dashboard_model.dart';


class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut(() => DashboardModel());
    // Get.lazyPut<HomeController>(() => HomeController());
    // Get.lazyPut<AccountController>(() => AccountController());
  }
}
