import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:noted/core/utils/firebase_api_service.dart';
import '/core/utils/app_theme.dart';
import '/data/data_sources/firebase_auth.dart';
import '/data/repos/user_repo_impl.dart';
import '/domain/use_cases/auth_use_cases/sign_in_use_case.dart';
import '/domain/use_cases/fetch_notes_use_case.dart';
import 'core/utils/app_router.dart';
import 'data/data_sources/notes_local_data_source.dart';
import 'data/data_sources/notes_remote_data_source.dart';
import 'data/repos/notes_repo_impl.dart';
import 'domain/use_cases/auth_use_cases/register_use_case.dart';
import 'presentation/manager/cubits/auth_cubits/login_cubit/login_cubit_cubit.dart';
import 'presentation/manager/cubits/auth_cubits/register_cubit/register_cubit_cubit.dart';
import 'presentation/manager/cubits/note_cubits/fetch_notes_cubit/fetch_notes_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          // get it the user repo
          create: (context) =>
              RegisterCubit(RegisterUsecase(UserRepoImpl(AuthService()))),
          child: Container(),
        ),
        BlocProvider(
          create: (context) =>
              LoginCubit(SignInUsecase(UserRepoImpl(AuthService()))),
          child: Container(),
        ),
        BlocProvider(
            create: (context) => FetchNotesCubit(
                  FetchNotesUsecase(GetIt.instance.get<NotesRepository>()),
                )
            // use .. to call the function
            //..fetchAllNotes(),
            ),
      ],
      child: MaterialApp(
        restorationScopeId: 'app',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.mainTheme,
        onGenerateRoute: AppRouter.route,
      ),
    );
  }
}
