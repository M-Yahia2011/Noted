import 'package:flutter/material.dart';

class TwoDividerWithTextInbetween extends StatelessWidget {
  const TwoDividerWithTextInbetween(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey.shade400,
          ),
        ),
        Text(text),
        Expanded(
          child: Divider(
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}