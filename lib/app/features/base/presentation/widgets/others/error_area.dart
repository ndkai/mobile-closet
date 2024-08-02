import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorArea extends StatelessWidget {
  final String text;
  const ErrorArea({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return text.isEmpty ? const SizedBox() : Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFFD4977)
      ),
      child: Center(
        child: Text(text, style: GoogleFonts.montserratAlternates(
            textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12)
        ),),
      ),
    );
  }
}
