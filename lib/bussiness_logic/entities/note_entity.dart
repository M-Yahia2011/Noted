import 'dart:ui';

class NoteEntity {
  final String title;
  final String body;
  final DateTime createdAt;
  final Color color;
  NoteEntity({
    required this.title,
    required this.body,
    required this.createdAt,
    required this.color
  });
}
