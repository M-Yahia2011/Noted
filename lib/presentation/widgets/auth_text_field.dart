import 'package:flutter/material.dart';
import 'package:noted/core/enums.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.hintText,
    required this.isObsecured,
    required this.textEditingController,
    required this.focusNode,
    required this.textFieldType,
  });
  final String hintText;

  final bool isObsecured;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final AuthTextFieldType textFieldType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // style: TextStyle(color: Colors.grey[400]),

      controller: textEditingController,
      obscureText: isObsecured,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please, Enter your $hintText";
        }
        if (textFieldType == AuthTextFieldType.email) {
          final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
          if (!emailRegex.hasMatch(value)) {
            return "Please, Enter a valid E-mail";
          }
        }
        return null;
      },
      keyboardType: textFieldType == AuthTextFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.visiblePassword,
      onEditingComplete: () {
        if (textFieldType == AuthTextFieldType.email) {
          FocusScope.of(context).nextFocus();
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      textInputAction: textFieldType == AuthTextFieldType.email
          ? TextInputAction.next
          : TextInputAction.done,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      onSaved: (value) {
        print(value);
        textEditingController.text = value!.trim();
        print(textEditingController.text);
      },
    );
  }
}
