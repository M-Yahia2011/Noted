import 'package:noted/data/services/web_service.dart';
import '../models/note_model.dart';

class NotesRepository {
  final NotesWebService notesWebService;

  NotesRepository(this.notesWebService);

  Future<List<Note>> getAllNotes() async {
    var notes = await notesWebService.getAllNotes();
    return notes.map((note) => Note.fromJson(note)).toList();
  }

  // add note

  // remove note

  // update note
 
}
