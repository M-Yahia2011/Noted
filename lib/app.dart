import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted/core/utils/api_service.dart';
import 'package:noted/data/data_sources/notes_local_data_source.dart';
import 'package:noted/data/data_sources/notes_remote_data_source.dart';
import 'package:noted/data/repos/notes_repo.dart';
import 'package:noted/domain/use_cases/fetch_notes_use_case.dart';
import 'core/utils/app_router.dart';

import 'presentation/manager/cubit/notes_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(
        fetchNotesUsecase: FetchNotesUsecase(
          NotesRepository(
            notesRemoteDatasource: NotesRemoteDatasource(
              ApiService(
                dio: Dio(),
              ),
            ),
            notesLocalDataSource: NotesLocalDataSource(),
          ),
        ),
      )..fetchAllNotes(),
      child: MaterialApp(
        restorationScopeId: 'app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        onGenerateRoute: AppRouter.route,
      ),
    );
  }
}
