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
      final file = File(path!);
      String contents = file.readAsStringSync();
      return Image.file(File(path!), height: height, width: width);
    } catch(e){
    }
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8)
      ),
    );
  }
}
