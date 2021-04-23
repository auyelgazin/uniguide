import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService{

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  final String uid;
  FirestoreService({this.uid});

  Future updateUserData({String fullName, String email, String position}) async{
    return await usersCollection.doc(uid).set({
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'position': position

    });
  }

  Stream<QuerySnapshot> get users{
    return usersCollection.snapshots();
  }

  Future getCurrentUserData() async{
    try{
      DocumentSnapshot ds = await usersCollection.doc(uid).get();
      String fullName = ds.get('fullName');
      String email = ds.get('email');
      String position = ds.get('position');
      return [fullName, email, position];
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}