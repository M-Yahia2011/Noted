import 'package:hive/hive.dart';
import 'package:noted/core/utils/constants.dart';

import '../../domain/entities/note_entity.dart';

class NotesLocalDataSource {
  List<NoteEntity> fetchAllNotes() {
    var box = Hive.box<NoteEntity>(Constants.kHiveNotesBox);
    return box.values.toList();
  }
}
