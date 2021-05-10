import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication.dart';

class FirebaseOperations with ChangeNotifier {
  UploadTask imageUploadTask;
  String initEmail, initAvatar, initFullname, initPosition;
  String get getInitFullname => initFullname;
  String get getInitAvatar => initAvatar;
  String get geiInitEmail => initEmail;
  String get getInitPosition => initPosition;



  Future createUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }

  Future updateAvatar(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .update(data).then((value) {
          initUserData(context);
          notifyListeners();
        });
  }

  Future initUserData(BuildContext context) async {
    return  FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .get()
        .then((doc) {
      print('Fetching user data...');
      initFullname = doc.data()['fullname'];
      initAvatar = doc.data()['avatar'];
      initEmail = doc.data()['email'];
      initPosition = doc.data()['position'];
      // initUserImage = doc.data()['userimage'];
      print([initFullname, initAvatar, initEmail, initPosition]);
      
      // print(initUserImage);
      notifyListeners();
    });
  }

  Future uploadPostData(String postId, dynamic data) async {
    return FirebaseFirestore.instance.collection('posts').doc(postId).set(data);
  }

  Future deleteUserData(String userUid, dynamic collection) async {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(userUid)
        .delete();
  }

  Future updateCaption(String postId, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .update(data);
  }

  Future submitChatroomData(String chatRoomName, dynamic chatRoomData) async {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatRoomName)
        .set(chatRoomData);
  }
}
