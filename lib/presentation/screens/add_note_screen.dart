import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '/core/utils/app_theme.dart';
import '/main.dart';
import '/presentation/manager/cubits/fetch_notes_cubit/fetch_notes_cubit.dart';
import '/data/repos/notes_repo_impl.dart';
import '/domain/use_cases/add_note_use_case.dart';
import '../manager/cubits/add_note_cubit/add_note_cubit.dart';
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
        AddNoteUsecase(getIt.get<NotesRepository>()),
      ),
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
                          // ignore: use_build_context_synchronously
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
                          // Navigator.of(context).pop();
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
                      const Center(child: CircularProgressIndicator()),
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
