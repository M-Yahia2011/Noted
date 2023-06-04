import 'package:flutter/material.dart';

import '../../domain/entities/note_entity.dart';
import 'note_card.dart';

class NotesGridView extends StatelessWidget {
  const NotesGridView({super.key, required this.notes});
  final List<NoteEntity> notes;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemCount: notes.length,
        itemBuilder: (context, idx) {
          return NoteCard(notes[idx]);
        });
  }
}
