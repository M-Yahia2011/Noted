import 'package:hive_flutter/hive_flutter.dart';

import '../../data/models/note_model.dart';
import '../../domain/entities/note_entity.dart';
import '../utils/constants.dart';

class HelperFunctions {
  static List<NoteModel> jsonListToNotesList(Map<String, dynamic> jsonData) {
    List<NoteModel> notes = [];
    for (var noteMap in jsonData['data']) {
      notes.add(NoteModel.fromJson(noteMap));
    }

    return notes;
  }


  static void saveAllNotesLocally(List<NoteEntity> notes) async {
    Box<NoteEntity> box = Hive.box<NoteEntity>(Constants.kHiveNotesBox);
    await box.addAll(notes);
  }
}
