import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final String uid;
  FirestoreService({this.uid});

  Future updateFullname(
      {String fullName, List searchIndex}) async {
    return await usersCollection.doc(uid).update({
      'fullname': fullName,
      'searchIndex': searchIndex,
    });
  }

  Future setAvatar({String avatar}) async {
    return await usersCollection.doc(uid).update({
      'avatar': avatar,
    });
  }

  updateProfilePic(picUrl) async {
    await FirebaseAuth.instance.currentUser.updateProfile(photoURL: picUrl);
  }
}
