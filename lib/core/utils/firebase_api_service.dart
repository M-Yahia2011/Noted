import 'package:firebase_database/firebase_database.dart';
import 'package:noted/data/data_sources/firebase_auth.dart';

class FirebaseApiService {
  String? userId;
  DatabaseReference? databaseRef;

  FirebaseApiService(String? uid) {
    userId = uid;
    FirebaseDatabase.instance.setPersistenceEnabled(false); // disable offline persistence
    FirebaseDatabase.instance.goOffline(); // close the existing connection
    FirebaseDatabase.instance.goOnline(); // reopen the connection
    databaseRef = FirebaseDatabase.instance.ref("users/$userId");
  }
  Future<Map<String, dynamic>> readNotes() async {
    final DataSnapshot dataSnapshot = await databaseRef!.child('notes').get();
    if (dataSnapshot.exists) {
      Map<String, dynamic> notesMap =
          Map<String, dynamic>.from(dataSnapshot.value as dynamic);

      return notesMap;
    }

    return {};
  }

  Future<String> createNote(Map<String, dynamic> noteMap) async {
    final noteRef = databaseRef!.child('notes').push();
    await noteRef.set(noteMap);
    return noteRef.key!;
  }

  Future<void> updateNote(Map<String, dynamic> noteMap, String noteId) async {
    await databaseRef!.child('notes/$noteId').update(noteMap);
  }

  Future<void> deleteNote({
    required String noteId,
  }) async {
    await databaseRef!.child('notes/$noteId').remove();
  }
}
