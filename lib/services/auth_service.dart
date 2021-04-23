import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uniguide/screens/auth/auth_controllers/login_controller.dart';
import 'package:uniguide/screens/auth/auth_controllers/signup_controller.dart';
import 'package:uniguide/screens/dashboard/dashboard_screen.dart';
import 'package:uniguide/services/firestore_service.dart';

class AuthService {
  FirebaseAuth auth;

  AuthService({this.auth});

  final LoginController controller = Get.put(LoginController());
  final SignupController signupController = Get.put(SignupController());

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
  }) async {
    if (signupController.error.value == '') {
      signupController.passwordLessThanSix();
      try {
        signupController.emptyAgain();
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // ignore: unnecessary_statements
        await FirestoreService(uid: auth.currentUser.uid).updateUserData(
          fullName: fullName,
          email: email,
          position: position,
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

 

  // -> Firestore part

}
