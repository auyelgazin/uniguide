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
  var avatar = ''.obs;

  // var password = ''.obs;

  Future getCurrentProfile() async {
    dynamic details = await FirestoreService(uid: firebaseAuth.currentUser.uid)
        .getCurrentUserData();
    if (details != null) {
      fullName.value = details[0];
      email.value = details[1];
      position.value = details[2];
      avatar.value = details[3];
    }
    print(details);
  }

  String getInitials(String displayName) => displayName.isNotEmpty
    ? displayName.trim().split(' ').map((l) => l[0]).take(2).join()
    : '';

//   String getCurrentPassword(String passw){
//     password.value = passw;
//     return password.value;
//   }

  var initFullName = ''.obs;
  var initAvatar = ''.obs;


}
