import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uniguide/screens/dashboard/dashboard_screen.dart';

class AuthService {

  FirebaseAuth auth;

  AuthService({this.auth});

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
      Get.to(() => DashboardScreen());
      return 'USER LOGGED IN';
      
    } on FirebaseException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future<String> Signup({
    String email,
    String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
        return 'USER SIGNED UP';
    } on FirebaseException catch (e) {
      print(e.message);
      return e.message;
    }
  }
}
