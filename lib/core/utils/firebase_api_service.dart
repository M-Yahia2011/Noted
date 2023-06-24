import 'package:firebase_database/firebase_database.dart';
import 'package:noted/data/data_sources/firebase_auth.dart';

class FirebaseApiService {
  DatabaseReference getDatabaseRef() {
    return FirebaseDatabase.instance
        .ref("users/${AuthService.authInstance.currentUser!.uid}");
  }

  Future<Map<String, dynamic>> readNotes() async {
    var databaseRef = FirebaseDatabase.instance
        .ref("users/${AuthService.authInstance.currentUser!.uid}");
    final DataSnapshot dataSnapshot = await databaseRef.child('notes').get();
    if (dataSnapshot.exists) {
      Map<String, dynamic> notesMap =
          Map<String, dynamic>.from(dataSnapshot.value as dynamic);

      return notesMap;
    }

    return {};
  }

  Future<String> createNote(Map<String, dynamic> noteMap) async {
    var databaseRef = getDatabaseRef();
    final noteRef = databaseRef.child('notes').push();
    await noteRef.set(noteMap);
    return noteRef.key!;
  }

  Future<void> updateNote(Map<String, dynamic> noteMap, String noteId) async {
    var databaseRef = getDatabaseRef();
    await databaseRef.child('notes/$noteId').update(noteMap);
  }

  Future<void> deleteNote({
    required String noteId,
  }) async {
    var databaseRef = getDatabaseRef();
    await databaseRef.child('notes/$noteId').remove();
  }
}
