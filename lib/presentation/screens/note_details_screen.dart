import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:noted/domain/entities/note_entity.dart';

import '../../domain/use_cases/update_note_use_case.dart';
import '../manager/cubits/note_cubits/fetch_notes_cubit/fetch_notes_cubit.dart';
import '../manager/cubits/note_cubits/update_note_cubit/update_note_cubit.dart';
import '/core/utils/app_theme.dart';
import '/main.dart';
import '/data/repos/notes_repo_impl.dart';
import '../widgets/body_text_field.dart';
import '../widgets/title_text_field.dart';

class NoteDetailsScreen extends StatefulWidget {
  static const routeName = '/note_details';

  const NoteDetailsScreen({super.key, required this.note});
  final NoteEntity note;
  @override
  // ignore: library_private_types_in_public_api
  _NoteDetailsScreen createState() => _NoteDetailsScreen();
}

class _NoteDetailsScreen extends State<NoteDetailsScreen> {
  final titleTextController = TextEditingController();
  final bodyTextController = TextEditingController();
  late FocusNode titleFocusNode;
  late FocusNode bodyFocusNode;
  Color? selectedColor = Colors.blue.shade100;
  GlobalKey formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleTextController.text = widget.note.title;
    bodyTextController.text = widget.note.body;
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
    return BlocProvider(
      create: (context) => UpdateNoteCubit(
        UpdateNoteUsecase(getIt.get<NotesRepository>()),
      ),
      child: BlocBuilder<UpdateNoteCubit, UpdateNoteState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(widget.note.color!),
            appBar: AppBar(
                title: Text(
                  titleTextController.text,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        // NoteEntity updatedNote = widget.note;
                        // updatedNote.

                        Map<String, dynamic> noteMap = {
                          "id": widget.note.id,
                          "title": titleTextController.text,
                          "body": bodyTextController.text,
                          "createdAt": widget.note.createdAt.toIso8601String(),
                          "color": selectedColor!.value
                        };
                        await BlocProvider.of<UpdateNoteCubit>(context)
                            .updateNote(noteMap)
                            .then((_) async {
                          await BlocProvider.of<FetchNotesCubit>(context)
                              .fetchAllNotes();
                          if (state is UpdateNoteDone) {
                            if (context.mounted) Navigator.of(context).pop();
                          }
                          if (state is UpdateNoteFailure) {
                            if (context.mounted) {
                              await showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                      content: Text(state.errorMessage),
                                    );
                                  }));
                            }
                          }
                        });
                      },
                      icon: const Icon(Icons.done)),
                  IconButton(
                      onPressed: () {
                        showColorPickerDialog(context);
                      },
                      icon: const Icon(
                        Icons.palette_outlined,
                      ))
                ]),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.always,
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
                                bodyTextController: bodyTextController,
                                bodyFocusNode: bodyFocusNode),
                          )
                        ],
                      ),
                    ),
                    if (state is UpdateNoteLoading)
                      Center(
                          child: CircularProgressIndicator(
                        color: AppTheme.bgColor,
                      )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> showColorPickerDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: BlockPicker(
                availableColors: AppTheme.cardsColors,
                pickerColor: selectedColor!, //default color
                onColorChanged: (Color color) {
                  //on color picked
                  setState(() {
                    selectedColor = color;
                  });
                },
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('DONE'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
