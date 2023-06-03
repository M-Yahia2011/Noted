import 'package:flutter/material.dart';
import 'package:noted/core/utils/app_theme.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    super.key,
    required this.titleTextController,
    required this.titleFocusNode,
    required this.bodyFocusNode,
  });

  final TextEditingController titleTextController;
  final FocusNode titleFocusNode;
  final FocusNode bodyFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: titleTextController,
      
      autofocus: false,
      focusNode: titleFocusNode,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        titleFocusNode.unfocus();
        FocusScope.of(context).requestFocus(bodyFocusNode);
      },
      style:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, height: 1),
      cursorColor: AppTheme.bgColor,
      decoration: const InputDecoration(
        hintText: "Title",
        hintStyle: TextStyle(fontSize: 15),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.all(15),
      ),
      keyboardType: TextInputType.text,
    );
  }
}
