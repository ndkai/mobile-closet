import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:clean_architechture/core/services/isar/schemas/closet.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/size/size_config.dart';
import '../buttons/positive_button.dart';
import '../others/error_area.dart';
import '../text_field/custom_text_form_field.dart';

class NewClosetDialogBuilder extends StatefulWidget {
  final Function(Closet) onConfirm;
  const NewClosetDialogBuilder({super.key, required this.onConfirm});

  @override
  State<NewClosetDialogBuilder> createState() => _NewClosetDialogBuilderState();
}

class _NewClosetDialogBuilderState extends State<NewClosetDialogBuilder> {
  final nameEdit = TextEditingController();
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Add new closet",
              style: GoogleFonts.montserratAlternates(
                  textStyle: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w700))).align(Alignment.center),
          const Gap(32),
          const Text("Closet name",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
              )),

          CustomTextFormField(
              label: "School, Office, Dating or Traveling",
              onChanged: (s) {},
              controller: nameEdit),
          const Gap(8),
          ErrorArea(text: error),
          const Gap(32),
          PositiveButton(onTap: (){
            if(nameEdit.text.isEmpty){
              setState(() {
                error = "Name can not empty";
              });
              return;
            }
            setState(() {
              error = "";
            });
            widget.onConfirm(Closet()..name = nameEdit.text);
            Navigator.pop(context);
          }, width: SizeConfig.screenWidth!, height: 44, label: "Confirm")
        ],
      ),
    );
  }
}
