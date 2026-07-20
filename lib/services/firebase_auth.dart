import 'package:firebase_auth/firebase_auth.dart';
import 'cache_helper.dart';

class AuthService {

  FirebaseAuth auth = FirebaseAuth.instance;
  CacheHelper cache = CacheHelper();

  Future<bool> signUp(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      await cache.setBool("isLogin", true);
      return true;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print(e.message);
      }
      return false;
    }
  }
  Future<bool> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await cache.setBool("isLogin", true);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e.message);
      }
      return false;
    }
  }
  Future<void> logout() async {
    try {
      await auth.signOut();
      cache.setBool("isLogin", false);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }


}