import 'package:hive/hive.dart';
import 'package:noted/core/utils/constants.dart';
import '../../domain/entities/note_entity.dart';

class NotesLocalDataSource {
  var box = Hive.box<NoteEntity>(Constants.kHiveNotesBox);

  List<NoteEntity> fetchAllNotes() {
    return box.values.toList();
  }

  void addNote(NoteEntity note) async {
    await box.add(note);
  }

  void deleteNote(NoteEntity note) {
    note.delete();
  }

  void updateNote(String noteId, Map<String, dynamic> updatedNote) {
    var oldNote = box.get(noteId);
    oldNote!.title = updatedNote["title"];
    oldNote.body = updatedNote["body"];
    oldNote.color = updatedNote["color"];
    oldNote.save();
  }

  void clearNotes() {
    box.clear();
  }
  
}
