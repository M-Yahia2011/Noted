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
    var jsonData = await apiService.get(endPoint: 'notes');
    List<NoteEntity> notes = HelperFunctions.jsonListToNotesList(jsonData);
    HelperFunctions.saveAllNotesLocally(notes);
    return notes;
  }

  Future<NoteEntity> addNote(NoteEntity note) async {
    
    var jsonData = await apiService.post(endPoint: 'notes', noteMap: note.toJson());
    var newNote = NoteModel.fromJson(jsonData);
    return newNote;
  }

}
