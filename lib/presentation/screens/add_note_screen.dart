import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/utils/app_theme.dart';
import '/main.dart';
import '/presentation/manager/cubits/fetch_notes_cubit/fetch_notes_cubit.dart';
import '/data/repos/notes_repo_impl.dart';
import '/domain/entities/note_entity.dart';
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
            appBar: AppBar(
                title: const Text("New Note"),
                centerTitle: true,
                actions: [
                  IconButton(
                      // padding: EdgeInsets.zero,
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        NoteEntity newNote = NoteEntity(
                            title: titleTextController.text,
                            body: bodyTextController.text,
                            createdAt: DateTime.now(),
                            color: AppTheme
                                .cardsColors[Random().nextInt(7)].value);
                        await BlocProvider.of<AddNoteCubit>(context)
                            .addNote(newNote)
                            .then((_) async {
                          await BlocProvider.of<FetchNotesCubit>(context)
                              .fetchAllNotes();
                          // ignore: use_build_context_synchronously
                          if (state is AddNoteFailed) {
                            if (context.mounted) {
                              print(state.errorMessage);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.errorMessage)));
                            }
                          }
                          // Navigator.of(context).pop();
                        });

                        // BlocListener<AddNoteCubit, AddNoteState>(
                        //   listener: (context, state) {
                        //     if (state is AddNoteLoading) {
                        //       showDialog(
                        //         barrierDismissible: false,
                        //         builder: (ctx) {
                        //           return const Center(
                        //             child: CircularProgressIndicator(
                        //               strokeWidth: 2,
                        //             ),
                        //           );
                        //         },
                        //         context: context,
                        //       );
                        //     }
                        //   },
                        //   // child: Container(),
                        // );
                        // await insert(newNote).then((_) => Navigator.of(context).pop());
                      },
                      icon: const Icon(Icons.done)),
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
}
