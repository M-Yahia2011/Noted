import 'package:flutter/material.dart';

import '../widgets/body_text_field.dart';
import '../widgets/title_text_field.dart';

class AddNoteScreen extends StatefulWidget {
  static const routeName = '/add_note_screen';

  const AddNoteScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final titleTextController = TextEditingController();
  final noteTextController = TextEditingController();
  late FocusNode titleFocusNode;
  late FocusNode bodyFocusNode;
  // Future<void> insert() async {
  //   Map<String, dynamic> noteMap = {
  //     "title": titleTextController.text,
  //     "note": noteTextController.text,
  //     "date": DateTime.now().toIso8601String(),
  //     "favorite": 0,
  //   };

  //   // await Provider.of<NoteProvider>(context, listen: false).addNote(noteMap);
  // }

  @override
  void initState() {
    super.initState();

    titleFocusNode = FocusNode();
    bodyFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.

    titleFocusNode.dispose();
    bodyFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () async {
              // if (titleTextController.text.isEmpty &&
              //     noteTextController.text.isEmpty) {
              //   Navigator.of(context).pop();
              // } else if (titleTextController.text.isEmpty &&
              //     noteTextController.text.isNotEmpty) {
              //   titleTextController.text = "No Title";
              // } else if (titleTextController.text.isNotEmpty &&
              //     noteTextController.text.isEmpty) {
              //   noteTextController.text = "";
              // }
              // await insert().then((_) => Navigator.of(context).pop());
            },
            icon: const Icon(Icons.done)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TitleTextField(
                  titleTextController: titleTextController,
                  titleFocusNode: titleFocusNode,
                  bodyFocusNode: bodyFocusNode),
              const Divider(
                color: Colors.grey,
                height: 0,
                thickness: 0,
              ),
              Expanded(
                child: BodyTextField(
                    noteTextController: noteTextController,
                    bodyFocusNode: bodyFocusNode),
              )
            ],
          ),
        ),
      ),
    );
  }
}

