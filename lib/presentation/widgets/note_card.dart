import 'package:flutter/material.dart';
import 'package:noted/domain/entities/note_entity.dart';
import 'package:noted/presentation/screens/note_details_screen.dart';
import 'package:intl/intl.dart' as intl;
import '../../core/utils/app_theme.dart';

class NoteCard extends StatelessWidget {
  final NoteEntity note;

  const NoteCard(this.note, {super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(note.color!),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoteDetailsScreen(note: note)));
        },
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
    );
  }
}
