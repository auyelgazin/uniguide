import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication.dart';

class FirebaseOperations with ChangeNotifier {
  String _initEmail, _initAvatar, _initFullname, _initPosition;
  List<dynamic> _initSearchIndex;
  String get getInitFullname => _initFullname;
  String get getInitAvatar => _initAvatar;
  String get geiInitEmail => _initEmail;
  String get getInitPosition => _initPosition;
  List<dynamic> get getInitSearchIndex => _initSearchIndex;



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
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .get()
        .then((doc) {
      print('Fetching user data...');
      
      _initFullname = doc.data()['fullname'];
      _initAvatar = doc.data()['avatar'];
      _initEmail = doc.data()['email'];
      _initPosition = doc.data()['position'];
      _initSearchIndex = doc.data()['searchIndex'];
      // initUserImage = doc.data()['userimage'];
      
      print([_initFullname, _initAvatar, _initEmail, _initPosition]);
      
      // print(initUserImage);
      notifyListeners();
      
    });
  }

  Future uploadPostData(String postId, dynamic data) async {
    return FirebaseFirestore.instance.collection('posts').doc(postId).set(data);
  }
}
