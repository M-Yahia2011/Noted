import 'package:dartz/dartz.dart';
import 'package:noted/domain/entities/note_entity.dart';
import '../../core/errors/failure.dart';
import '../../data/repos/notes_repo.dart';
import 'use_case.dart';


class FetchNotesUsecase implements UseCase<List<NoteEntity>, NoParameter> {
  FetchNotesUsecase(this.notesRepository);
  final NotesRepository notesRepository;
  
  @override
  Future<Either<Failure, List<NoteEntity>>> execute([NoParameter? parameter])async {
   return await notesRepository.getAllNotes();
  }
  


}
