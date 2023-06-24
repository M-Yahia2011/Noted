import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static FirebaseAuth authInstance = FirebaseAuth.instance;
  static Future<String?> getToken() async {
    return authInstance.currentUser?.getIdToken(true);
  }

  Future<UserCredential> signIn(String email, String password) async {
    return await authInstance.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> register(String email, String password) async {
    var credentials = authInstance.createUserWithEmailAndPassword(
        email: email, password: password);
    await authInstance.currentUser?.getIdToken(true);
    return credentials;
  }

  Future<void> signOut(String email, String password) async {
    await authInstance.signOut();
    
  }
}
