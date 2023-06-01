import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted/presentation/screens/add_note_screen.dart';
import '../../core/utils/app_theme.dart';
import '../manager/cubit/notes_cubit.dart';
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
    // BlocProvider.of<NotesCubit>(context).fetchAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.mainColor,
        drawer: const Drawer(),
        appBar: AppBar(
          title: const Text("Noted"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: BlocBuilder<NotesCubit, NotesState>(
          builder: (context, state) {
            if (state is NotesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NotesLoaded) {
              return NotesGridView(notes: state.notes);
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
          onPressed: () {
            Navigator.of(context).pushNamed(AddNoteScreen.routeName);
          },
          label: Text(
            "Add Note",
            style: AppTheme.noteBodyStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
