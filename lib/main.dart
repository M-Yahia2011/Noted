import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'app.dart';
import 'core/utils/firebase_api_service.dart';
import 'data/data_sources/firebase_auth.dart';
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


  GetIt.instance.registerSingleton<NotesRepository>(
    NotesRepository(
      notesRemoteDatasource: NotesRemoteDatasource(
        FirebaseApiService(
          
          AuthService.authInstance.currentUser?.uid,
        ),
      ),
      notesLocalDataSource: NotesLocalDataSource(),
    ),
  );

  runApp(const MyApp());
}


