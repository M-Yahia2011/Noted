import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '/domain/entities/note_entity.dart';
import '../../domain/use_cases/update_note_use_case.dart';
import '../manager/cubits/note_cubits/fetch_notes_cubit/fetch_notes_cubit.dart';
import '../manager/cubits/note_cubits/update_note_cubit/update_note_cubit.dart';
import '/core/utils/app_theme.dart';
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
  Color? selectedColor;
  GlobalKey formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    titleTextController.text = widget.note.title;
    bodyTextController.text = widget.note.body;
    titleFocusNode = FocusNode();
    bodyFocusNode = FocusNode();
    selectedColor = Color(widget.note.color!);
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
        UpdateNoteUsecase(GetIt.instance.get<NotesRepository>()),
      ),
      child: BlocConsumer<UpdateNoteCubit, UpdateNoteState>(
        listener: (context, state) async {
          
          if (state is UpdateNoteLoading) {
            isLoading = true;
          } else if (state is UpdateNoteFailure) {
            isLoading = false;
            await showDialog(
                context: context,
                builder: ((context) {
                  return AlertDialog(
                    content: Text(state.errorMessage),
                  );
                }));
          } else if (state is UpdateNoteDone) {
            isLoading = false;
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Scaffold(
              backgroundColor: selectedColor,
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
                          widget.note.title = titleTextController.text;
                          widget.note.body = bodyTextController.text;
                          widget.note.color = selectedColor!.value;

                          if (context.mounted) {
                            await BlocProvider.of<UpdateNoteCubit>(context)
                                .updateNote(widget.note);
                          }
                          if (context.mounted) {
                            await BlocProvider.of<FetchNotesCubit>(context)
                                .fetchAllNotes();
                          }
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
                  child: Form(
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancle'),
              ),
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
