// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:noted/domain/use_cases/delete_note_use_case.dart';

import '../../../../../domain/entities/note_entity.dart';



part 'delete_note_state.dart';

class DeleteNoteCubit extends Cubit<DeleteNoteState> {
  DeleteNoteCubit(this.deleteNoteUsecase) : super(DeleteNoteInitial());
  final DeleteNoteUsecase deleteNoteUsecase;

  Future<void> deleteNote(NoteEntity note) async {
    emit(DeleteNoteLoading());
    var result = await deleteNoteUsecase.execute(note);
    result.fold((failure) {
      emit(DeleteNoteFailed(failure.message));
    }, (r) {
      emit(DeleteNoteSuccess());
    });
  }
}
