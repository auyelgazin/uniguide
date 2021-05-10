import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication.dart';

class FirebaseOperations with ChangeNotifier {
  UploadTask imageUploadTask;
  String initEmail, initAvatar, initFullname, initPosition; //, initUserImage;
  String get getInitFullname => initFullname;
  String get getInitAvatar => initAvatar;
  String get geiInitEmail => initEmail;
  String get getInitPosition => initPosition;
  // String get getInitUserImage => initUserImage;


  // Future uploadUserAvatar(BuildContext context) async {
  //   Reference imageReference = FirebaseStorage.instance.ref().child(
  //       'userProfileAvatar/${Provider.of<LandingUtils>(context, listen: false).getUserAvatar.path}/${TimeOfDay.now()}');
  //   imageUploadTask = imageReference.putFile(
  //       Provider.of<LandingUtils>(context, listen: false).getUserAvatar);
  //   await imageUploadTask.whenComplete(() {
  //     print('Image uploaded!');
  //   });
  //   imageReference.getDownloadURL().then((url) {
  //     Provider.of<LandingUtils>(context, listen: false).userAvatarUrl =
  //         url.toString();
  //     print(
  //         'the user profile avatar url => ${Provider.of<LandingUtils>(context, listen: false).userAvatarUrl}');
  //     notifyListeners();
  //   });
  // }

  Future createUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
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
