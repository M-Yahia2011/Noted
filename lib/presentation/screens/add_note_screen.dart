import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get_it/get_it.dart';
import '../../core/utils/firebase_api_service.dart';
import '../../data/data_sources/notes_local_data_source.dart';
import '../../data/data_sources/notes_remote_data_source.dart';
import '../manager/cubits/note_cubits/add_note_cubit/add_note_cubit.dart';
import '../manager/cubits/note_cubits/fetch_notes_cubit/fetch_notes_cubit.dart';
import '/core/utils/app_theme.dart';
import '/main.dart';

import '/data/repos/notes_repo_impl.dart';
import '/domain/use_cases/add_note_use_case.dart';

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
  final bodyTextController = TextEditingController();
  late FocusNode titleFocusNode;
  late FocusNode bodyFocusNode;
  Color? selectedColor = Colors.blue.shade100;
  GlobalKey formKey = GlobalKey<FormState>();

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
    return BlocProvider(
      create: (context) => AddNoteCubit(
        AddNoteUsecase(GetIt.instance.get<NotesRepository>(),
      ),),
      child: BlocBuilder<AddNoteCubit, AddNoteState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: selectedColor,
            appBar: AppBar(
                title: const Text("New Note"),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();

                        Map<String, dynamic> noteMap = {
                          "title": titleTextController.text,
                          "body": bodyTextController.text,
                          "createdAt": DateTime.now().toIso8601String(),
                          "color": selectedColor!.value
                        };

                        await BlocProvider.of<AddNoteCubit>(context)
                            .addNote(noteMap)
                            .then((_) async {
                          await BlocProvider.of<FetchNotesCubit>(context)
                              .fetchAllNotes();

                          if (state is AddNoteFailed) {
                            if (mounted) {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                      content: Text(state.errorMessage),
                                    );
                                  }));
                            }
                          }
                          if (context.mounted) {
                            Navigator.of(context).pop();
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
                    if (state is AddNoteLoading)
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
