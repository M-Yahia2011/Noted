// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:noted/domain/entities/note_entity.dart';
import 'package:noted/domain/use_cases/add_note_use_case.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit(this.addNoteUsecase) : super(AddNoteInitial());

  final AddNoteUsecase addNoteUsecase;

  Future<void> addNote(Map<String,dynamic> noteMap) async {

    emit(AddNoteLoading());
    
    var result = await addNoteUsecase.execute(noteMap);

    result.fold((failure) {
      emit(AddNoteFailed(failure.message));
    }, (newNote) {
      emit(AddNoteDone(newNote));
    });
  }
}
