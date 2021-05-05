import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/screens/auth/auth_controllers/login_controller.dart';
import 'package:uniguide/screens/auth/auth_controllers/signup_controller.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:uniguide/screens/dashboard/dashboard_screen.dart';
import 'package:uniguide/services/firestore_service.dart';

class AuthService {
  FirebaseAuth auth;

  AuthService({this.auth});

  final LoginController controller = Get.put(LoginController());
  final SignupController signupController = Get.put(SignupController());
  final DashboardController dashboardController = Get.put(DashboardController());

  String initFullName, initAvatar;
  String get getInitFullName => initFullName;
  String get getInitAvatar => initAvatar;

  Future<Stream<User>> AlreadyRegistered({FirebaseAuth auth}) async {
    Stream<User> stream = await auth.authStateChanges();
    return stream;
  }

  Future<String> Login({
    String email,
    String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      // dashboardController.getCurrentPassword(password);
      Get.offNamed('/dashboard');
      return 'USER LOGGED IN';
    } on FirebaseException catch (e) {
      print(e.message);
      controller.isIncorrect();
      return e.message;
    }
  }

  Future<String> Signup({
    String email,
    String password,
    String fullName,
    String position,
    String avatar,
  }) async {
    if (signupController.error.value == '') {
      signupController.passwordLessThanSix();
      try {
        signupController.emptyAgain();
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // dashboardController.getCurrentPassword(password);
        // ignore: unnecessary_statements
        await FirestoreService(uid: auth.currentUser.uid).updateUserData(
          fullName: fullName,
          email: email,
          position: position,
          avatar: null,
        );
        Get.offNamed('/congratz');
        return 'USER SIGNED UP';
      } on FirebaseException catch (e) {
        print(e.message);
        signupController.passwordLessThanSix();
        return e.message;
      }
    } else {
      print('fill the fields correctly');
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future initUserData() async {
    return FirebaseFirestore.instance.collection('users').doc(auth.currentUser.uid).get().then((doc) {
      print('fetching user data');

      dashboardController.fullName.value = doc.data()['fullName'];
      dashboardController.avatar.value = doc.data()['avatar'];

      print(dashboardController.fullName.value);
      print(dashboardController.avatar.value);
    });
  }

  Future uploadPostData(String postID, dynamic data) async {
    return FirebaseFirestore.instance.collection('posts').doc(postID).set(data);
  }



 

  // -> Firestore part

}
