import 'dart:math';

import 'package:flutter/material.dart';
import 'package:noted/presentation/screens/note_details_screen.dart';

import '../../../data/models/note_model.dart';
import '../../../helpers/app_theme.dart';
import 'package:intl/intl.dart' as intl;

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note});
  final Note note;
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
            color: AppSTheme.cardsColors[Random().nextInt(7)],
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              child: Text(
                note.title,
                style: AppSTheme.noteTitleStyle,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text(
                  note.body,
                  style: AppSTheme.noteBodyStyle,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FittedBox(
                  child: Text(
                    intl.DateFormat.yMMMd().format(note.createdAt),
                    style: AppSTheme.noteBodyStyle
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
