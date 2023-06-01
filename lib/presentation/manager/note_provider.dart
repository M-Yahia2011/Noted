// import 'package:flutter/material.dart';
// import 'package:noted/core/errors/failure.dart';
// import 'package:noted/domain/entities/note_entity.dart';
// import 'package:noted/domain/use%20cases/fetch_notes_use_case.dart';

// class NotesProvider with ChangeNotifier {
//   NotesProvider(this.fetchNotesUsecase);

//   final FetchNotesUsecase fetchNotesUsecase;

//   List<NoteEntity> _notes = [];

//   List<NoteEntity> get notes {
//     return [..._notes];
//   }

//   Future<void> fetchAllNotes() async {
//     var result = await fetchNotesUsecase.execute();
//     result.fold((failure) {
//       ServerFailure(failure.message);
//     }, (fetchedNotes) {
//       _notes = fetchedNotes;
//     });
//     notifyListeners();
//   }
// }
