import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication with ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String userUid;
  String get getUserUid => userUid;

  String getUID() {
    String uid = firebaseAuth.currentUser.uid;
    print('UID: $uid');
    return uid;
    
  }

  Future logIntoAccount(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    User user = userCredential.user;
    userUid = user.uid;
    print(userUid);
    notifyListeners();
  }

  Future createAccount(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    User user = userCredential.user;
    userUid = user.uid;
    print('Created account Uid => $userUid');
    notifyListeners();
  }

  Future logOutViaEmail() {
    return firebaseAuth.signOut();
  }
}
