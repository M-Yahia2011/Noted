import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '/data/data_sources/notes_local_data_source.dart';
import '/data/data_sources/notes_remote_data_source.dart';
import '/domain/entities/note_entity.dart';
import '/core/errors/failure.dart';
import '../../domain/repos/notes_repo_abstract.dart';

class NotesRepository extends NotesRepoAbstract {
  final NotesRemoteDatasource notesRemoteDatasource;
  final NotesLocalDataSource notesLocalDataSource;
  NotesRepository(
      {required this.notesRemoteDatasource,
      required this.notesLocalDataSource});

  @override
  Future<Either<Failure, List<NoteEntity>>> getAllNotes() async {
    try {
      List<NoteEntity> localNotes = notesLocalDataSource.fetchAllNotes();
      if (localNotes.isNotEmpty) {
        return right(localNotes);
      }
      List<NoteEntity> remoteNotes =
          await notesRemoteDatasource.fetchAllNotes();
      return right(remoteNotes);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, NoteEntity>> addNote(
      Map<String, dynamic> noteMap) async {
    try {
      var newNote = await notesRemoteDatasource.addNote(noteMap);

      notesLocalDataSource.addNote(newNote);
      return right(newNote);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(NoteEntity note) async {
    try {
      notesLocalDataSource.deleteNote(note);
      await notesRemoteDatasource.deleteNote(note.id);
      return right(null);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
  //TODO: update note
}
