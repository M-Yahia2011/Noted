import 'package:hive/hive.dart';
part 'note_entity.g.dart';
@HiveType(typeId: 0)
class NoteEntity extends HiveObject{
  @HiveField(0)
  final String title;
@HiveField(1)
  final String body;
@HiveField(2)
  final DateTime createdAt;
@HiveField(3)
  final int? color;
  NoteEntity({
    required this.title,
    required this.body,
    required this.createdAt,
    required this.color
  });
}
