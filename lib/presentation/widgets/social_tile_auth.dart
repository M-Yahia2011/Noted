import 'package:flutter/material.dart';

class SocialTileAuthCard extends StatelessWidget {
  const SocialTileAuthCard({
    super.key,
    required this.imagePath,
  });
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 1,
                blurStyle: BlurStyle.outer)
          ],
          border: Border.all(color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Image.asset(
          imagePath,
          height: 60,
        ),
      ),
    );
  }
}
