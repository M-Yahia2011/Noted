import '../../domain/entities/note_entity.dart';

class NotesLocalDataSource {
  // var box = Hive.box<NoteEntity>(Constants.kHiveNotesBox);

  List<NoteEntity> fetchAllNotes() {
    return [];

    //  box.values.toList();
  }

  void addNote(NoteEntity note) async {
    // await box.add(note);
  }

  void deleteNote(NoteEntity note) {
    // note.delete();
  }

  void clearNotes() {
    // box.clear();
  }
  // TODO: use firebase offline solution instead of hive
}
