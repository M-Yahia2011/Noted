import 'package:firebase_database/firebase_database.dart';

class FirebaseApiService {
  String? _userId;
  DatabaseReference? _databaseRef;


  Future<Map<String, dynamic>> readNotes() async {
    final DataSnapshot dataSnapshot = await _databaseRef!.child('notes').get();
    if (dataSnapshot.exists) {
      Map<String, dynamic> notesMap =
          Map<String, dynamic>.from(dataSnapshot.value as dynamic);
      return notesMap;
    }
    return {};
  }

  Future<String> createNote(Map<String, dynamic> noteMap) async {
    final noteRef = _databaseRef!.child('notes').push();
    await noteRef.set(noteMap);
    return noteRef.key!;
  }

  Future<void> updateNote(Map<String, dynamic> noteMap, String noteId) async {
    await _databaseRef!.child('notes/$noteId').update(noteMap);
  }

  Future<void> deleteNote({
    required String noteId,
  }) async {
    await _databaseRef!.child('notes/$noteId').remove();
  }

 void setUserId(String? userId) {
    _userId = userId;
    if (_userId != null) {
      _databaseRef = FirebaseDatabase.instance.ref("users/$_userId");
    } else {
      _databaseRef = null;
    }
  }
}