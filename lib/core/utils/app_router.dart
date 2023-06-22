import 'package:flutter/material.dart';
import 'package:noted/data/data_sources/firebase_auth.dart';
import 'package:noted/presentation/screens/register_screen.dart';
import '/presentation/screens/sign_in_screen.dart';
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
          case SignInScreen.routeName:
            return const SignInScreen();
          case RegisterScreen.routeName:
            return const RegisterScreen();

          default:
            print(AuthService.authInstance.currentUser);
            if (AuthService.authInstance.currentUser != null) {
              return const AllNotesScreen();
            } else {
              return const RegisterScreen();
            }
        }
      },
    );
  }
}
