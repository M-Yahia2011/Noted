import 'package:hive/hive.dart';
part 'note_entity.g.dart';

@HiveType(typeId: 0)
class NoteEntity extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String body;
  @HiveField(3)
  final DateTime createdAt;
  @HiveField(4)
  int? color;

  NoteEntity(
      {required this.id,
      required this.title,
      this.body = "",
      required this.createdAt,
      required this.color});

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "color": color,
        "createdAt": createdAt.toIso8601String(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          body == other.body &&
          createdAt == other.createdAt &&
          color == other.color;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      body.hashCode ^
      createdAt.hashCode ^
      color.hashCode;
}
