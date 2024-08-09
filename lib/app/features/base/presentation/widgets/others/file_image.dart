import 'dart:io';

import 'package:flutter/material.dart';

class AppFileImage extends StatelessWidget {
  final String? path;
  final double height;
  final double width;
  const AppFileImage({super.key, this.path, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    try{
      return Container(
        height: height,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: FileImage(File(path!)),
              fit: BoxFit.fitHeight
            )
        ),
      );
    } catch(e){
    }
    return Container(
      height: height,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8)
      ),
    );
  }
}
