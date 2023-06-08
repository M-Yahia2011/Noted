import '/core/utils/api_service.dart';

import '/data/models/note_model.dart';
import '/domain/entities/note_entity.dart';
import 'data_source_abstract.dart';
import '../../core/errors/functions.dart';

class NotesRemoteDatasource extends DatasourceAbstract {
  NotesRemoteDatasource(this.apiService);
  final ApiService apiService;

  @override
  Future<List<NoteEntity>> fetchAllNotes() async {
    var jsonData = await apiService.get(endPoint: 'notes.json');
    List<NoteEntity> notes = HelperFunctions.jsonListToNotesList(jsonData);
    HelperFunctions.saveAllNotesLocally(notes);
    return notes;
  }

  Future<NoteEntity> addNote(Map<String, dynamic> noteMap) async {
    var jsonData =
        await apiService.post(endPoint: 'notes.json', noteMap: noteMap);
    noteMap["id"] = jsonData["name"];
    var newNote = NoteModel.fromJson(noteMap);
    return newNote;
  }

  Future<void> deleteNote(String noteId) async {
    await apiService.delete(endPoint: "notes", noteId: noteId);
  }

  Future<NoteEntity> updateNote(Map<String, dynamic> noteMap) async {
    String noteId = noteMap["id"];
    noteMap.remove("id");
    var jsonData = await apiService.put(
        endPoint: 'notes', noteMap: noteMap, noteId: noteId);
    jsonData["id"] = noteId;
    var newNote = NoteModel.fromJson(jsonData);
    return newNote;
  }
}
