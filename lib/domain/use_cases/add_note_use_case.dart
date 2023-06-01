import 'package:dartz/dartz.dart';

import 'package:noted/core/errors/failure.dart';
import 'package:noted/data/repos/notes_repo.dart';
import 'package:noted/domain/entities/note_entity.dart';

import 'use_case.dart';

class AddNoteUsecase extends UseCase<NoteEntity, Map?> {
  final NotesRepository notesRepository;

  AddNoteUsecase(this.notesRepository);

  @override
  Future<Either<Failure, NoteEntity>> execute([Map? parameter]) async {
    return await notesRepository.addNote();
  }
}