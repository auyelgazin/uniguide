import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uniguide/screens/auth/auth_controllers/login_controller.dart';
import 'package:uniguide/screens/dashboard/dashboard_screen.dart';

class AuthService {
  FirebaseAuth auth;

  AuthService({this.auth});

  final LoginController controller = Get.put(LoginController());

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
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Get.offNamed('/dashboard');
      return 'USER SIGNED UP';
    } on FirebaseException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  // String authored(){
  //   if (auth.currentUser.uid != null) {
  //     return '/welcome';
  //   } else return '/login';
  // }
}


