import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardModel extends GetxController {
  final CollectionReference _blogCollectionRef =
      FirebaseFirestore.instance.collection('blogs');

  // DashboardModel() {
  //   getBlog();
  // }

  // getBlog() async {
  //   _blogCollectionRef.get().then((value) {
  //     print(value.docs[0].data());
  //   });
  // }
}
