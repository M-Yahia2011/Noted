import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:noted/data/repos/notes_repo_impl.dart';

class AuthService {
  //TODO: may be the problem is here
  static FirebaseAuth authInstance = FirebaseAuth.instance;
  static Future<String?> getToken() async {
    return authInstance.currentUser?.getIdToken(true);
  }

  Future<UserCredential> signIn(String email, String password) async {
    return authInstance.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> register(String email, String password) async {
    return await authInstance.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut(String email, String password) async {
    await GetIt.instance.unregister<NotesRepository>();
    await authInstance.signOut();
  }
}
