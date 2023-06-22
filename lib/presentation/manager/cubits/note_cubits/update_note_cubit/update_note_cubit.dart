// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import '/domain/entities/note_entity.dart';
import '/domain/use_cases/update_note_use_case.dart';

part 'update_note_state.dart';

class UpdateNoteCubit extends Cubit<UpdateNoteState> {
  UpdateNoteCubit(this._updateNoteUsecase) : super(UpdateNoteInitial());

  final UpdateNoteUsecase _updateNoteUsecase;

    Future<void> updateNote(NoteEntity note) async {

    emit(UpdateNoteLoading());
    
    var result = await _updateNoteUsecase.execute(note);

    result.fold((failure) {
      emit(UpdateNoteFailure(failure.message));
    }, (newNote) {
      emit(UpdateNoteDone(newNote));
    });
  }
}
