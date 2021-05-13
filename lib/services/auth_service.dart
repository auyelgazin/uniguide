import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth auth;
  AuthService({this.auth});

  Future<Stream<User>> AlreadyRegistered({FirebaseAuth auth}) async {
    Stream<User> stream = await auth.authStateChanges();
    return stream;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
