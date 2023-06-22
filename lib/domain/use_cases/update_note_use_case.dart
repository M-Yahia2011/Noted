
import 'package:dartz/dartz.dart';
import '/core/errors/failure.dart';
import '/data/repos/notes_repo_impl.dart';
import '/domain/use_cases/use_case.dart';

import '../entities/note_entity.dart';

class UpdateNoteUsecase extends UseCase<NoteEntity,  NoteEntity> {
  final NotesRepository _notesRepository;

  UpdateNoteUsecase(this._notesRepository);

  @override
  Future<Either<Failure, NoteEntity>> execute([NoteEntity? parameter]) async {
  return await _notesRepository.updateNote(parameter!);
  }
 
}
