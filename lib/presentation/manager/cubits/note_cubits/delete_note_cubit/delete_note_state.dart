part of 'delete_note_cubit.dart';

@immutable
abstract class DeleteNoteState {}

class DeleteNoteInitial extends DeleteNoteState {}

class DeleteNoteLoading extends DeleteNoteState {}

class DeleteNoteSuccess extends DeleteNoteState {}

class DeleteNoteFailed extends DeleteNoteState {
  final String errorMessage;

  DeleteNoteFailed(this.errorMessage);
}
