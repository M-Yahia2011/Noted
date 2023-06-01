import 'package:dartz/dartz.dart';
import 'package:noted/domain/entities/note_entity.dart';
import 'package:noted/core/errors/failure.dart';

// determine what should happen in the repo in data layer
abstract class NotesRepoAbstract {
  Future<Either<Failure, List<NoteEntity>>> getAllNotes();
  Future<Either<Failure, NoteEntity>> addNote();
}