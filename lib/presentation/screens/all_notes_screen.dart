import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/data_sources/firebase_auth.dart';
import '/data/repos/notes_repo_impl.dart';
import '/domain/use_cases/delete_note_use_case.dart';
import '/main.dart';
import '/presentation/screens/add_note_screen.dart';
import '/presentation/screens/sign_in_screen.dart';
import '../../core/utils/app_theme.dart';
import '../manager/cubits/note_cubits/delete_note_cubit/delete_note_cubit.dart';
import '../manager/cubits/note_cubits/fetch_notes_cubit/fetch_notes_cubit.dart';
import '../widgets/notes_gridview.dart';

class AllNotesScreen extends StatefulWidget {
  const AllNotesScreen({super.key});
  static const routeName = "/all_notes";

  @override
  State<AllNotesScreen> createState() => _AllNotesScreenState();
}

class _AllNotesScreenState extends State<AllNotesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await BlocProvider.of<FetchNotesCubit>(context).fetchAllNotes();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DeleteNoteCubit(DeleteNoteUsecase(getIt.get<NotesRepository>())),
      child: SafeArea(
        child: Scaffold(
          drawer: Drawer(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.black54,
                child: const Center(
                  child: Text(
                    "NOTED",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Spacer(),
              ListTile(
                tileColor: Colors.blue.shade100,
                title: const Text("Sign Out"),
                onTap: () async {
                  await AuthService.authInstance.signOut();
                  if (context.mounted) {
                    Navigator.of(context)
                        .pushReplacementNamed(SignInScreen.routeName);
                  }
                },
              ),
            ],
          )),
          appBar: AppBar(
            title: const Text("Noted"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  onPressed: () {
                    // TODO: Search feature
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: BlocBuilder<FetchNotesCubit, FetchNotesState>(
            builder: (context, state) {
              if (state is NotesLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.bgColor,
                  ),
                );
              } else if (state is NotesLoaded) {
                if (state.notes.isEmpty) {
                  return const Center(
                    child: Text("NO NOTES WERE FOUND!"),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NotesGridView(notes: state.notes),
                );
              } else if (state is NotesFailure) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else {
                return Container();
              }
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            elevation: 2,
            onPressed: () {
              Navigator.of(context).pushNamed(AddNoteScreen.routeName);
            },
            label: Text(
              "Add Note",
              style: AppTheme.noteBodyStyle
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
