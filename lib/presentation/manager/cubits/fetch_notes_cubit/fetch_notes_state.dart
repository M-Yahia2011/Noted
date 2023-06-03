part of 'fetch_notes_cubit.dart';

@immutable
abstract class FetchNotesState {}

class FetchNotesInitial extends FetchNotesState {}

class NotesLoading extends FetchNotesState {}

class NotesLoaded extends FetchNotesState {
  final List<NoteEntity> notes;

  NotesLoaded(this.notes);
}

class NotesFailure extends FetchNotesState {
  final String errorMessage;

  NotesFailure(this.errorMessage);
}
