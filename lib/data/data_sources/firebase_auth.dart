import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:noted/core/utils/firebase_api_service.dart';
import 'package:noted/data/repos/notes_repo_impl.dart';

class AuthService {
  final FirebaseApiService _firebaseApiService = FirebaseApiService();
  static FirebaseAuth authInstance = FirebaseAuth.instance;
  static Future<String?> getToken() async {
    return authInstance.currentUser?.getIdToken(true);
  }

  Future<UserCredential> signIn(String email, String password) async {
    final UserCredential userCredential = await authInstance
        .signInWithEmailAndPassword(email: email, password: password);
    final userId = userCredential.user?.uid;
    _firebaseApiService.setUserId(userId);
    return userCredential;
  }

  Future<UserCredential> register(String email, String password) async {
  
    final UserCredential userCredential = await authInstance
        .createUserWithEmailAndPassword(email: email, password: password);
    final userId = userCredential.user?.uid;
    _firebaseApiService.setUserId(userId);
    return userCredential;
  }

  Future<void> signOut(String email, String password) async {
    await GetIt.instance.unregister<NotesRepository>();
    await authInstance.signOut();
  }
}
