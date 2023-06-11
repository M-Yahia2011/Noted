// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages, unused_import
import 'package:meta/meta.dart';
import 'package:noted/domain/use_cases/fetch_notes_use_case.dart';

import '../../../../../domain/entities/note_entity.dart';

part 'fetch_notes_state.dart';

class FetchNotesCubit extends Cubit<FetchNotesState> {
  FetchNotesCubit({required this.fetchNotesUsecase})
      : super(FetchNotesInitial());

  final FetchNotesUsecase fetchNotesUsecase;

  Future<void> fetchAllNotes() async {
    emit(NotesLoading());
    var result = await fetchNotesUsecase.execute();
    result.fold((failure) {
      emit(NotesFailure(failure.message));
    }, (fetchedNotes) {
      emit(NotesLoaded(fetchedNotes));
    });
  }
}
