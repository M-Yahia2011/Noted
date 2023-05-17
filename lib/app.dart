import 'package:flutter/material.dart';
import 'package:noted/bussiness_logic/cubit/notes_cubit.dart';
import 'package:noted/data/repo/notes_repo.dart';
import 'package:noted/data/services/web_service.dart';
import 'package:noted/presentation/screens/all_notes_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(NotesRepository(NotesWebService())),
      child: MaterialApp(
        restorationScopeId: 'app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        onGenerateRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) {
              switch (routeSettings.name) {
                case AllNotesScreen.routeName:
                  return const AllNotesScreen();
                default:
                  return const AllNotesScreen();
              }
            },
          );
        },
      ),
    );
  }
}
