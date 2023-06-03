import 'package:flutter/material.dart';
import 'package:noted/core/utils/app_theme.dart';

class BodyTextField extends StatelessWidget {
  const BodyTextField({
    super.key,
    required this.bodyTextController,
    required this.bodyFocusNode,
  });

  final TextEditingController bodyTextController;
  final FocusNode bodyFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: bodyTextController,
      focusNode: bodyFocusNode,
      // textAlign: TextAlign.center,
      textInputAction: TextInputAction.done,
      onEditingComplete: () => bodyFocusNode.unfocus(),
      style: const TextStyle(fontSize: 15),
      cursorColor: AppTheme.bgColor,
      showCursor: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: "Write your note!",
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
      maxLines: null,
    );
  }
}
