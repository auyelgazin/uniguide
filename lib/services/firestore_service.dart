import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup({String collectionPosition, String fullName, String email}) async{
  CollectionReference users = FirebaseFirestore.instance.collection(collectionPosition);
  FirebaseAuth auth = FirebaseAuth.instance;

  String uid = auth.currentUser.uid.toString();
  users.add({'uid': uid, 'fullName': fullName, 'email': email});
  return;
}