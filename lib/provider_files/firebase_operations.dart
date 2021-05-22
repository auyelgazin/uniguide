import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/consants.dart';
import 'package:uniguide/screens/dashboard/chat_screens/models/message.dart';
import 'package:uniguide/screens/dashboard/chat_screens/models/user.dart';
import 'package:uniguide/screens/dashboard/chat_screens/utils.dart';
import 'authentication.dart';

class FirebaseOperations with ChangeNotifier {
  String _initEmail, _initAvatar, _initFullname, _initPosition;
  List<dynamic> _initSearchIndex;
  String get getInitFullname => _initFullname;
  String get getInitAvatar => _initAvatar;
  String get geiInitEmail => _initEmail;
  String get getInitPosition => _initPosition;
  List<dynamic> get getInitSearchIndex => _initSearchIndex;

  Stream<List<UserModel>> getUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .transform(Utils.transformer(UserModel.fromJson));

  Future uploadMessage(String uid, String message) async {
    final refMessage =
        FirebaseFirestore.instance.collection('chats/$uid/messages');

    final newMessage = Message(
      uid: FirebaseAuth.instance.currentUser.uid,
      avatar: _initAvatar,
      fullname: _initFullname,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessage.add(newMessage.toJson());
  }

  Stream<List<Message>> getMessages(String uid) {
    FirebaseFirestore.instance
        .collection('users/$uid/messages')
        // .orderBy()
        .snapshots()
        .transform(Utils.transformer(Message.fromJson));
  }

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
        .update(data)
        .then((value) {
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
      print('$arrow Fetching user data...');

      _initFullname = doc.data()['fullname'];
      _initAvatar = doc.data()['avatar'];
      _initEmail = doc.data()['email'];
      _initPosition = doc.data()['position'];
      _initSearchIndex = doc.data()['searchIndex'];
      // initUserImage = doc.data()['userimage'];

      print('$arrow Authorized user\'s data: ${[
        _initFullname,
        _initAvatar,
        _initEmail,
        _initPosition
      ]}');

      notifyListeners();
    });
  }

  Future uploadPostData(String postId, dynamic data) async {
    return FirebaseFirestore.instance.collection('posts').doc(postId).set(data);
  }
}
