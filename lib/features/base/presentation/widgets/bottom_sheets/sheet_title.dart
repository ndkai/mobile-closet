import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/theme/theme.dart';

class SheetTitle extends StatelessWidget {
  final String name;
  final Function? onDone;
  const SheetTitle({super.key, required this.name, this.onDone});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: AppTheme.currentTheme.textTheme.titleMedium!.merge(
                  const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
         Text(
          'Close',
          textAlign: TextAlign.right,
          style: GoogleFonts.roboto(
            color: const Color(0xFF001F7B),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ).onClick(() {
          onDone ?? Navigator.of(context).pop();
        }).align(Alignment.bottomRight),
      ],
    ).padding(const EdgeInsets.all(6));
  }
}
