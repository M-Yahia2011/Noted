import '/core/utils/firebase_api_service.dart';
import '/data/data_sources/firebase_auth.dart';
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
// TODO: Implement connectivity to handle network absence
  }
}