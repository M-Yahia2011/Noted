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

  // bool _isCacheStale(List<NoteEntity> remoteData, List<NoteEntity> localData) {
  //   return localData.length != remoteData.length ||
  //       !listEquals(localData, remoteData);
  // }

  @override
  Future<Either<Failure, List<NoteEntity>>> getAllNotes() async {
    try {
      // List<NoteEntity> localNotes = notesLocalDataSource.fetchAllNotes();
      // if (localNotes.isNotEmpty) {
      //   return right(localNotes);
      // }
      List<NoteEntity> remoteNotes =
          await notesRemoteDatasource.fetchAllNotes();
      // bool isCacheOutDated = _isCacheStale(remoteNotes, localNotes);

      // if (isCacheOutDated) {
      //   notesLocalDataSource.box.clear();
      //   print(notesLocalDataSource.box.values);
      //   notesLocalDataSource.box.addAll(remoteNotes);
        return right(remoteNotes);
      // } 
      // else {
      //   return right(localNotes);
      // }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, NoteEntity>> addNote(
      Map<String, dynamic> noteMap) async {
    try {
      NoteEntity newNote = await notesRemoteDatasource.addNote(noteMap);

      notesLocalDataSource.addNote(newNote);
      return right(newNote);
    } catch (e) {
      if (e is DioException) {
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
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, NoteEntity>> updateNote(
      NoteEntity note) async {
    try {
      
      NoteEntity updatedNote = await notesRemoteDatasource.updateNote(note);
      
      
      return right(updatedNote);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
  //TODO: update note

