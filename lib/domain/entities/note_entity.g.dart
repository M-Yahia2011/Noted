// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteEntityAdapter extends TypeAdapter<NoteEntity> {
  @override
  final int typeId = 0;

  @override
  NoteEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteEntity(
      title: fields[0] as String,
      body: fields[1] as String,
      createdAt: fields[2] as DateTime,
      color: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NoteEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
