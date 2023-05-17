import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted/bussiness_logic/cubit/notes_cubit.dart';

import 'package:noted/helpers/app_theme.dart';

import '../widgets/note_card.dart';

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
    BlocProvider.of<NotesCubit>(context).getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppSTheme.mainColor,
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
          // buildWhen: (previous, current) {
          //   if (current is NotesFetched && previous is! NotesFetched) {
          //     return true;
          //   } else {
          //     return false;
          //   }
          // },
          builder: (context, state) {
            if (state is NotesFetched && state.notes.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                    itemCount: state.notes.length,
                    itemBuilder: (context, idx) {
                      return NoteCard(note: state.notes[idx]);
                    }),
              );
            } else if (state is NotesFetched && state.notes.isEmpty) {
              return const Center(
                child: Text("No Notes!"),
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text(
            "Add Note",
            style:
                AppSTheme.noteBodyStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
