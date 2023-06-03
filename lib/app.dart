import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted/domain/use_cases/fetch_notes_use_case.dart';
import 'package:noted/main.dart';
import 'core/utils/app_router.dart';
import 'data/repos/notes_repo_impl.dart';
import 'presentation/manager/cubits/fetch_notes_cubit/fetch_notes_cubit.dart';




class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchNotesCubit(
        fetchNotesUsecase: FetchNotesUsecase(
         getIt.get<NotesRepository>()
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
