part of 'notes_cubit.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesFetched extends NotesState {
  final List<Note> notes;

  NotesFetched(this.notes);
}
