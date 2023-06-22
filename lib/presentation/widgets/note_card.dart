import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/domain/entities/note_entity.dart';
import '/presentation/screens/note_details_screen.dart';
import 'package:intl/intl.dart' as intl;
import '../../core/utils/app_theme.dart';
import '../manager/cubits/note_cubits/delete_note_cubit/delete_note_cubit.dart';
import '../manager/cubits/note_cubits/fetch_notes_cubit/fetch_notes_cubit.dart';

class NoteCard extends StatelessWidget {
  final NoteEntity note;

  const NoteCard(this.note, {super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: Color(note.color!),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NoteDetailsScreen(note: note)));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Text(
                      note.title,
                      style: AppTheme.noteTitleStyle,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        note.body,
                        style: AppTheme.noteBodyStyle,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5, bottom: 5),
                        child: FittedBox(
                          child: Text(
                            intl.DateFormat.yMMMd().format(note.createdAt),
                            style: AppTheme.noteBodyStyle
                                .copyWith(
                                  overflow: TextOverflow.fade,
                                )
                                .copyWith(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: IconButton(
            onPressed: () async {
              await BlocProvider.of<DeleteNoteCubit>(context).deleteNote(note);
              if (context.mounted) {
                await BlocProvider.of<FetchNotesCubit>(context).fetchAllNotes();
              }
            },
            icon: const Icon(Icons.delete),
          ),
        ),
      ],
    );
  }
}
