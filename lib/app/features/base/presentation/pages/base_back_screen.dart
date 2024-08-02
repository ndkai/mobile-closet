import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/theme/theme.dart';


class BaseBackScreen extends StatelessWidget {
  final Widget child;
  final bool resizeToAvoidBottomInset;
  final String title;

  const BaseBackScreen(
      {super.key,
      required this.child,
      this.resizeToAvoidBottomInset = false,
      this.title = "",
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: AppBar(
          leading: Container(
            height: 48,
            width: 48,
            child: Center(child: const Icon(Icons.arrow_back_ios_new, color: Colors.blue,),),
          ).onClick(() => Navigator.pop(context)),
          title: Text(title, style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w700,
                  fontSize: 16)),),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey.withOpacity(.2),
        body: child);
  }
}
