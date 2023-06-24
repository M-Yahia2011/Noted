import 'dart:convert';

import '/domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  final String noteId;
  final String noteTitle;
  final String noteBody;
  final DateTime noteCreatedAt;
  final int noteColor;

  NoteModel(
      {required this.noteId,
      required this.noteTitle,
      required this.noteBody,
      required this.noteCreatedAt,
      required this.noteColor})
      : super(
            id: noteId,
            title: noteTitle,
            body: noteBody,
            createdAt: noteCreatedAt,
            color: noteColor);

  factory NoteModel.fromRawJson(String str) =>
      NoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        noteId: json["id"],
        noteTitle: json["title"],
        noteBody: json["body"],
        noteColor: json["color"] ?? 1,
        noteCreatedAt: DateTime.parse(json["createdAt"]),
      );


}
