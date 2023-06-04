import 'package:hive/hive.dart';
part 'note_entity.g.dart';

@HiveType(typeId: 0)
class NoteEntity extends HiveObject{
  @HiveField(0)
  String id;
  @HiveField(1)
  final String title;
@HiveField(2)
  final String body;
@HiveField(3)
  final DateTime createdAt;
@HiveField(4)
  final int? color;

  NoteEntity({
    required this.id,
    required this.title,
     this.body="",
    required this.createdAt,
    required this.color
  });

 Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "color": color,
        "createdAt": createdAt.toIso8601String(),
      };
}
