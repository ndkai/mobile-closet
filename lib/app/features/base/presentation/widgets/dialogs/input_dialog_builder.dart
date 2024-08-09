import 'package:clean_architechture/core/commons/constant.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/size/size_config.dart';
import '../buttons/negative_button.dart';
import '../buttons/positive_button.dart';
import '../text_field/custom_text_form_field.dart';

class InputFieldDialogBuilder extends StatefulWidget {
  final String title;
  final String hint;
  final List<String> additions;
  final Function(String) onConfirm;
  const InputFieldDialogBuilder({super.key, required this.title, required this.hint, required this.onConfirm, required this.additions});

  @override
  State<InputFieldDialogBuilder> createState() => _InputFieldDialogBuilderState();
}

class _InputFieldDialogBuilderState extends State<InputFieldDialogBuilder> {
  TextEditingController controller = TextEditingController();
  List<String> selected = [];
  String keyword = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Information input", style: GoogleFonts.roboto(
              textStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 16)
          ),),
          const Gap(16),
          Text(widget.title, style: GoogleFonts.roboto(
              textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14)
          ),).align(Alignment.centerLeft),
          CustomTextFormField(label: widget.hint, onChanged: (s){
            setState(() {
              keyword = s.toLowerCase();
            });
          }, controller: controller),
          const Gap(16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: widget.additions.where((element) => element.toLowerCase().contains(keyword)).take(5).map((e) => _chip(e)).toList()),
          ),
          Gap(widget.additions.where((element) => element.toLowerCase().contains(keyword)).isNotEmpty ? 16 : 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NegativeButton(width:  SizeConfig.screenWidth! * 0.3, height: 40, onTap: (){
                Navigator.pop(context);
              }),
              PositiveButton(onTap: (){
                Navigator.pop(context);
                widget.onConfirm(controller.text);
              }, width: SizeConfig.screenWidth! * 0.3, height: 40, label: "Ok")
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String name){
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: selected.contains(name) ? Colors.blueGrey : Colors.grey.withOpacity(.3),
          borderRadius: BorderRadius.circular(20)
      ),
      child: Text(name, style: GoogleFonts.roboto(
          textStyle: TextStyle(color: selected.contains(name) ? Colors.white : Colors.black, fontWeight: FontWeight.w400, fontSize: 14)),),
    ).onClick((){
      controller.text = name;
    });
  }
}
