import 'package:firebase_database/firebase_database.dart';
import '/data/data_sources/firebase_auth.dart';

class FirebaseApiService {
  static final String _userId = AuthService.authInstance.currentUser!.uid;
  final DatabaseReference databaseRef =
      FirebaseDatabase.instance.ref("users/$_userId");


  Future<Map<String, dynamic>> readNotes() async {
    final DataSnapshot dataSnapshot = await databaseRef.child('notes').get();
    if (dataSnapshot.exists) {
      Map<String, dynamic> notesMap =
          Map<String, dynamic>.from(dataSnapshot.value as dynamic);

      return notesMap;
    }

    return {};
  }
  Future<String> createNote(Map<String, dynamic> noteMap) async {
    final noteRef = databaseRef.child('notes').push();
    await noteRef.set(noteMap);
    return noteRef.key!;
  }

  Future<void> updateNote(Map<String, dynamic> noteMap,String noteId) async {
    await databaseRef
        .child('notes/$noteId')
        .update(noteMap);
  }

  Future<void> deleteNote({
    required String noteId,
  }) async {
    await databaseRef.child('notes/$noteId').remove();
  }
}