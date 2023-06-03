import 'dart:convert';

import 'package:noted/domain/entities/note_entity.dart';

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
            title: noteTitle,
            body: noteBody,
            createdAt: noteCreatedAt,
            color: noteColor);

  factory NoteModel.fromRawJson(String str) =>
      NoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        noteId: json["data"]["id"].toString(),
        noteTitle: json["data"]["attributes"]["title"],
        noteBody: json["data"]["attributes"]["body"],
        noteColor: json["data"]["attributes"]["color"]?? 1,
        noteCreatedAt: DateTime.parse(json["data"]["attributes"]["createdAt"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": noteId,
        "title": noteTitle,
        "body": noteBody,
        "color": noteColor,
        "createdAt": noteCreatedAt.toIso8601String(),
      };
}
