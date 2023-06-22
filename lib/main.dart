import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/core/utils/firebase_api_service.dart';
import '/domain/entities/note_entity.dart';
import 'app.dart';
import 'data/data_sources/notes_local_data_source.dart';
import 'data/data_sources/notes_remote_data_source.dart';
import 'data/repos/notes_repo_impl.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(NoteEntityAdapter());
  await Hive.openBox<NoteEntity>("notes_box");

  getIt.registerSingleton<NotesRepository>(
    NotesRepository(
      notesRemoteDatasource: NotesRemoteDatasource(FirebaseApiService()),
      notesLocalDataSource: NotesLocalDataSource(),
    ),
  );

  runApp(const MyApp());
}

final getIt = GetIt.instance;
// Fp8cUkwWqetCXFu4