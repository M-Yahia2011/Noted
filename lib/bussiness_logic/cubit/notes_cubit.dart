import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:noted/data/models/note_model.dart';
import 'package:noted/data/repo/notes_repo.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit(this.notesRepository) : super(NotesInitial());

  late NotesRepository notesRepository;
  List<Note> notes=[];
  List<Note> getAllNotes() {
    notesRepository.getAllNotes().then((notes) {
      emit(NotesFetched(notes));
      this.notes = notes;
    });
    return notes;
  }
}
