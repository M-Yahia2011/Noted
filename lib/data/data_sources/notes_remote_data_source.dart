import 'package:hive/hive.dart';
import 'package:noted/core/utils/api_service.dart';
import 'package:noted/core/utils/constants.dart';
import 'package:noted/data/models/note_model.dart';
import 'package:noted/domain/entities/note_entity.dart';

import 'data_source_abstract.dart';

class NotesRemoteDatasource extends DatasourceAbstract {
  final ApiService apiService;

  NotesRemoteDatasource(this.apiService);

  @override
  Future<List<NoteEntity>> fetchAllNotes() async {
    var jsonData = await apiService.get(endPoint: 'notes');
    List<NoteEntity> notes = getNotesList(jsonData);
    saveNotesLocally(notes);
    return notes;
  }

  Future<NoteEntity> addNote(Map<String, dynamic> noteMap) async {
    var jsonData = await apiService.post(endPoint: 'notes', noteMap: noteMap);
    var box = Hive.box<NoteEntity>(Constants.kHiveNotesBox);
    var newNote = NoteModel.fromJson(jsonData);
    box.add(newNote);
    return newNote;
  }

  // helpers function
  List<NoteModel> getNotesList(Map<String, dynamic> jsonData) {
    List<NoteModel> notes = [];
    for (var noteMap in jsonData['data']) {
      notes.add(NoteModel.fromJson(noteMap));
    }

    return notes;
  }

  void saveNotesLocally(List<NoteEntity> notes) async {
    var box = Hive.box<NoteEntity>(Constants.kHiveNotesBox);
    await box.addAll(notes);
  }
}
