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
        height: 56,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            onPressed: function,
            child: Text(
              buttonText,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));
  }
}
