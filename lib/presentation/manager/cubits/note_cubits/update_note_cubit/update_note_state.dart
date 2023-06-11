part of 'update_note_cubit.dart';

@immutable
abstract class UpdateNoteState {}

class UpdateNoteInitial extends UpdateNoteState {}

class UpdateNoteLoading extends UpdateNoteState {}

class UpdateNoteDone extends UpdateNoteState {
  final NoteEntity newNote;

  UpdateNoteDone(this.newNote);
}

class UpdateNoteFailure extends UpdateNoteState {
  final String errorMessage;

  UpdateNoteFailure(this.errorMessage);
}
