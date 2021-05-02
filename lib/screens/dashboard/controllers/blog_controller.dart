import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uniguide/services/firestore_service.dart';

import '../profile_screen.dart';

class BlogController extends GetxController {
  Future getData(String collection) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collection).get();
    return snapshot.docs;
  }

  Future gotdata() {
    FirebaseFirestore.instance.collection('blogs').get().then((value) {
      value.docs.forEach((element) {
        print(element.data());
      });
    });
  }

  Future getCurrentProfile() async {
    dynamic details = await FirestoreService(uid: firebaseAuth.currentUser.uid)
        .getCurrentUserData();
    if (details != null) {
      String fullName = details[0];
      String email = details[1];
      String position = details[2];

      print(fullName);
      print(email);
      print(position);
    }
  }

}
