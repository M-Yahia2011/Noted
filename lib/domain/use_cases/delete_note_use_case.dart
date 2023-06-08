import 'package:dartz/dartz.dart';
import 'package:noted/core/errors/failure.dart';
import 'package:noted/data/repos/notes_repo_impl.dart';
import 'package:noted/domain/entities/note_entity.dart';
import 'package:noted/domain/use_cases/use_case.dart';

class DeleteNoteUsecase extends UseCase<void, NoteEntity?> {
  final NotesRepository notesRepository;

  DeleteNoteUsecase(this.notesRepository);
  @override
  Future<Either<Failure, void>> execute([NoteEntity? parameter]) async {
    return await notesRepository.deleteNote(parameter!);
  }
}
