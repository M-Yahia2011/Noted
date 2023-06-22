import 'package:dartz/dartz.dart';
import '/core/errors/failure.dart';
import '/data/repos/notes_repo_impl.dart';
import '/domain/entities/note_entity.dart';
import '/domain/use_cases/use_case.dart';

class DeleteNoteUsecase extends UseCase<void, NoteEntity?> {
  final NotesRepository notesRepository;

  DeleteNoteUsecase(this.notesRepository);
  @override
  Future<Either<Failure, void>> execute([NoteEntity? parameter]) async {
    return await notesRepository.deleteNote(parameter!);
  }
}
