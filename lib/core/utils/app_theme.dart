import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color bgColor = const Color(0xffe2e2fe);
  static Color mainColor = const Color(0xff000633);
  static Color accentColor = const Color(0xff0065ff);
  static List<Color> cardsColors = [
    Colors.white,
    Colors.red.shade100,
    Colors.yellow.shade100,
    Colors.blue.shade100,
    Colors.orange.shade100,
    Colors.pink.shade100,
    Colors.green.shade100,
  ];
  static TextStyle noteTitleStyle = GoogleFonts.roboto(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle noteBodyStyle =
      GoogleFonts.nunito(fontSize: 16, color: Colors.black);
}
