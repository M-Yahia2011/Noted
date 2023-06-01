import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noted/domain/entities/note_entity.dart';
import 'app.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteEntityAdapter());
  await Hive.openBox<NoteEntity>("notes_box");
  runApp(const MyApp());
}
// Fp8cUkwWqetCXFu4