
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.buttonText,
    required this.function,
  });
  final String buttonText;
  final Function()? function;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: function,
            child: Text(
              buttonText,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            )));
  }
}
