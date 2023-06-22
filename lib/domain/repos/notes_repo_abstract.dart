import 'package:dartz/dartz.dart';
import '/domain/entities/note_entity.dart';
import '/core/errors/failure.dart';

// determine what should happen in the repo in data layer
abstract class NotesRepoAbstract {
  Future<Either<Failure, List<NoteEntity>>> getAllNotes();
  // sent as entity, recieved as entity and repo will change it to model
  Future<Either<Failure, NoteEntity>> addNote(Map<String, dynamic> noteMap);
  Future<Either<Failure, void>> deleteNote(NoteEntity note);
  Future<Either<Failure, NoteEntity>> updateNote(NoteEntity note);
}
