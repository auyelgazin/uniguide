import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String _userUid;
  String get getUserUid => _userUid;

  void getUID() {
    _userUid = _firebaseAuth.currentUser.uid;
  }

  Future logIntoAccount(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    User user = userCredential.user;
    _userUid = user.uid;
    print(_userUid);
    notifyListeners();
  }

  Future createAccount(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    User user = userCredential.user;
    _userUid = user.uid;
    print('Created account Uid => $_userUid');
    notifyListeners();
  }

  Future logOutViaEmail() {
    return _firebaseAuth.signOut();
  }
}
