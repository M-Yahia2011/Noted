import 'dart:math';
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
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NoteDetailsScreen(note: note)));
      },
      child: Ink(
        decoration: BoxDecoration(
            color: AppTheme.cardsColors[Random().nextInt(7)],
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(8),
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
                FittedBox(
                  child: Text(
                    intl.DateFormat.yMMMd().format(note.createdAt),
                    style: AppTheme.noteBodyStyle
                        .copyWith(
                          overflow: TextOverflow.fade,
                        )
                        .copyWith(fontSize: 12),
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
