import 'package:get/get.dart';
import 'package:uniguide/services/firestore_service.dart';

import '../profile_screen.dart';

class DashboardController extends GetxController {
  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    if (tabIndex == 2) {
      getCurrentProfile();
    }
    update();
    
  }

  var fullName = ''.obs;
  var email = ''.obs;
  var position = ''.obs;

  Future getCurrentProfile() async {
    dynamic details = await FirestoreService(uid: firebaseAuth.currentUser.uid)
        .getCurrentUserData();
    if (details != null) {
      fullName.value = details[0];
      email.value = details[1];
      position.value = details[2];
    }
  }
}
