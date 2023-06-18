import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // this is like dio
  FirebaseAuth authInstance = FirebaseAuth.instance;

  Future<UserCredential> signIn(String email, String password) async {
    return await authInstance.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> register(String email, String password) async {
    return authInstance.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut(String email, String password) async {
    await authInstance.signOut();
  }
}
