import 'package:get/get.dart';

class DashboardController extends GetxController {
  String getInitials(String displayName) => displayName.isNotEmpty
      ? displayName.trim().split(' ').map((l) => l[0]).take(2).join()
      : '';

  var blogTitle = ''.obs;
  var chatTitle = ''.obs;
  var profileTitle = ''.obs;
  var writeTitle = ''.obs;
}
