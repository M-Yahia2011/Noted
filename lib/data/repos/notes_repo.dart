import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:noted/data/data_sources/notes_local_data_source.dart';
import 'package:noted/data/data_sources/notes_remote_data_source.dart';
import 'package:noted/domain/entities/note_entity.dart';
import 'package:noted/core/errors/failure.dart';
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
  Future<Either<Failure, NoteEntity>> addNote() {
    // TODO: implement addNote
    throw UnimplementedError();
  }

  // add note

  // remove note

  // update note
}
