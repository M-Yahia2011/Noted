
import 'package:dartz/dartz.dart';
import 'package:noted/core/errors/failure.dart';
import 'package:noted/data/repos/notes_repo_impl.dart';
import 'package:noted/domain/use_cases/use_case.dart';

import '../entities/note_entity.dart';

class UpdateNoteUsecase extends UseCase<NoteEntity,  Map<String,dynamic>?> {
  final NotesRepository _notesRepository;

  UpdateNoteUsecase(this._notesRepository);

  @override
  Future<Either<Failure, NoteEntity>> execute([Map<String,dynamic>? parameter]) async {
  return await _notesRepository.updateNote(parameter!);
  }
 
}
