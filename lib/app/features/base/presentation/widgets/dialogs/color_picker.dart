import 'package:clean_architechture/app/features/base/presentation/widgets/buttons/positive_button.dart';
import 'package:clean_architechture/core/commons/constant.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/size/size_config.dart';
import '../../../../../../core/models/clothes_color.dart';
import '../buttons/negative_button.dart';

class ColorPickerBuilder extends StatefulWidget {
  final List<String> colors;
  final Function(List<String>) onConfirm;
  const ColorPickerBuilder({super.key, required this.colors, required this.onConfirm});

  @override
  State<ColorPickerBuilder> createState() => _ColorPickerBuilderState();
}

class _ColorPickerBuilderState extends State<ColorPickerBuilder> {
  List<String> selectedColors = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedColors = widget.colors;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Gap(16),
          Text("Choose colors",
              style: GoogleFonts.montserratAlternates(
                  textStyle: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w700))),
          const Gap(32),
          Wrap(
            children: Constant.popularColors.map((e) => _buildColors(e)).toList(),
          ),
          const Gap(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NegativeButton(width:  SizeConfig.screenWidth! * 0.3, height: 45, onTap: (){
                Navigator.pop(context);
              }),
              PositiveButton(onTap: (){
                widget.onConfirm(selectedColors);
              }, width: SizeConfig.screenWidth! * 0.3, height: 45, label: "Ok")
            ],
          ),
          const Gap(16),
        ],
      ),
    );
  }

  Widget _buildColors(ClothesColor color){
    bool isActive = selectedColors.contains(color.name);
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: isActive ? Colors.blue.shade700 : Colors.grey.withOpacity(.3)
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 14,
            width: 14,
            decoration: BoxDecoration(
              color: Color(color.color),
              borderRadius: BorderRadius.circular(3)
            ),
          ),
          const Gap(5),
          Text("${color.name}  ",
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 12))),

        ],
      ),
    ).onClick((){
      setState(() {
        if(isActive){
          selectedColors.remove(color.name);
        } else {
          selectedColors.add(color.name);
        }
      });
    });
  }
}
