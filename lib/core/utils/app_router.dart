import 'package:flutter/material.dart';
import 'package:noted/presentation/screens/auth_screen.dart';
import '../../presentation/screens/add_note_screen.dart';
import '../../presentation/screens/all_notes_screen.dart';

class AppRouter {
  static Route<dynamic> route(RouteSettings routeSettings) {
    return MaterialPageRoute<void>(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          case AllNotesScreen.routeName:
            return const AllNotesScreen();
          case AddNoteScreen.routeName:
            return const AddNoteScreen();
          case AuthScreen.routeName:
            return const AuthScreen();
          default:
            return const AuthScreen();
        }
      },
    );
  }
}
