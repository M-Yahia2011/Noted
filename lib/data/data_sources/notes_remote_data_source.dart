import 'package:noted/core/utils/firebase_api_service.dart';
import 'package:noted/data/data_sources/firebase_auth.dart';
import '/data/models/note_model.dart';
import '/domain/entities/note_entity.dart';
import 'data_source_abstract.dart';
import '../../core/errors/functions.dart';

class NotesRemoteDatasource extends DatasourceAbstract {
  NotesRemoteDatasource(this.apiService);
  final FirebaseApiService apiService;
  final String userId = AuthService.authInstance.currentUser!.uid;
  @override
  Future<List<NoteEntity>> fetchAllNotes() async {
    var result = await apiService.readNotes();
    var notes = HelperFunctions.jsonListToNotesList(result);
    HelperFunctions.saveAllNotesLocally(notes);
    return notes;
  }

  Future<NoteEntity> addNote(Map<String, dynamic> noteMap) async {
    String noteId = await apiService.createNote(noteMap);

    noteMap["id"] = noteId;
    var newNote = NoteModel.fromJson(noteMap);
    return newNote;
  }

  Future<void> deleteNote(String noteId) async {
    await apiService.deleteNote(noteId: noteId);
  }

// argument should be the note it self in update
  Future<NoteEntity> updateNote(NoteEntity note) async {
    String noteId = note.id;
    
    await apiService.updateNote(note.toJson(), noteId);
    return note;
  }
}

// class NotesRemoteDatasource extends DatasourceAbstract {
//   NotesRemoteDatasource(this.apiService);
//   final ApiService apiService;
//   final String userId = AuthService.authInstance.currentUser!.uid;
//   @override
//   Future<List<NoteEntity>> fetchAllNotes() async {
//     var jsonData = await apiService.get(endPoint: 'users/$userId/notes.json');
//     List<NoteEntity> notes = HelperFunctions.jsonListToNotesList(jsonData);
//     HelperFunctions.saveAllNotesLocally(notes);
//     return notes;
//   }

//   Future<NoteEntity> addNote(Map<String, dynamic> noteMap) async {
//     var jsonData = await apiService.post(
//         endPoint: 'users/$userId/notes.json', noteMap: noteMap);

//     noteMap["id"] = jsonData["name"];
//     var newNote = NoteModel.fromJson(noteMap);
//     return newNote;
//   }

//   Future<void> deleteNote(String noteId) async {
//     await apiService.delete(endPoint: "notes", noteId: noteId);
//   }

//   Future<NoteEntity> updateNote(Map<String, dynamic> noteMap) async {
//     String noteId = noteMap["id"];
//     noteMap.remove("id");
//     var jsonData = await apiService.put(
//         endPoint: 'notes', noteMap: noteMap, noteId: noteId);
//     jsonData["id"] = noteId;
//     var newNote = NoteModel.fromJson(jsonData);
//     return newNote;
//   }
// }
