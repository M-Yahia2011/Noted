import 'package:flutter/material.dart';
import 'package:noted/domain/entities/note_entity.dart';

class NoteDetailsScreen extends StatefulWidget {
  const NoteDetailsScreen({super.key, required this.note});
  static const routeName = "\note_details";
  final NoteEntity note;
  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.note.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(widget.note.color!),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: TextFormField(
            controller: _textEditingController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please input note';
              }
              return null;
            },
            readOnly: false,
            // inputFormatters: [LengthLimitingTextInputFormatter(70)],
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              hintText: "enter note",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            minLines: 6,
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ),
      ),
    );
  }
}
