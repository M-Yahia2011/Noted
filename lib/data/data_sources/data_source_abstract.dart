import '../../domain/entities/note_entity.dart';

abstract class DatasourceAbstract {
  Future<List<NoteEntity>> fetchAllNotes();
}
