import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService{

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  final String uid;
  FirestoreService({this.uid});

  Future updateUserData(String fullName, String email) async{
    return await usersCollection.doc(uid).set({
      'uid': uid,
      'fullName': fullName,
      'email': email,
      
    });
  }
}