import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardModel extends GetxController {
  final CollectionReference _blogCollectionRef =
      FirebaseFirestore.instance.collection('blogs');
}
