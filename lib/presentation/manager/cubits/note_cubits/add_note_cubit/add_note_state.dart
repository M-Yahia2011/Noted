part of 'add_note_cubit.dart';

@immutable
abstract class AddNoteState {}

class AddNoteInitial extends AddNoteState {}

class AddNoteLoading extends AddNoteState {}

class AddNoteDone extends AddNoteState {
  final NoteEntity newNote;

  AddNoteDone(this.newNote);
}

class AddNoteFailed extends AddNoteState {
  final String errorMessage;

  AddNoteFailed(this.errorMessage);
}
