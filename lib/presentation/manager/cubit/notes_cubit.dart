// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:noted/domain/use_cases/fetch_notes_use_case.dart';
import '../../../domain/entities/note_entity.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit({required this.fetchNotesUsecase}) : super(NotesInitial());

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
