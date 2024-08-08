import 'package:clean_architechture/app/features/base/presentation/widgets/bottom_sheets/sheet_title.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../config/size/size_config.dart';
import '../../../../../../config/theme/theme.dart';
import '../../../../../../core/commons/constant.dart';
import '../search/search_widget.dart';

class MaterialSheerBuilder extends StatefulWidget {
  final List<String> materials;
  final ValueChanged<List<String>> onChange;
  const MaterialSheerBuilder({super.key, required this.materials, required this.onChange});

  @override
  State<MaterialSheerBuilder> createState() => _MaterialSheerBuilderState();
}

class _MaterialSheerBuilderState extends State<MaterialSheerBuilder> {
  String keyword = "";
  late List<String> selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = widget.materials;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight! * 0.8,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Colors.white),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetTitle(
            name: "Choose material",
          ),
          const Gap(10),
          SearchWidget(
            title: "Search",
            onChanged: (s){
              setState(() {
                keyword = s;
              });
            },
          ),
          const Gap(10),
          Expanded(
              child: ListView(
                children: Constant.materials.where((element) => element.toLowerCase().contains(keyword.toLowerCase())).map((e) => _buildList(e)).toList()
              ).noIndicatorListView()),
          const Gap(40),
        ],
      ),
    );
  }

  Widget _buildList(String color) {
    return DecoratedBox(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: .3))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Gap(10),
              Text(
                color,
                style: AppTheme.currentTheme.textTheme.titleMedium!
                    .merge(const TextStyle(color: Colors.black)),
              ),
            ],
          ),
          selected.contains(color) ? Container(
            width: 16,
            height: 16,
            decoration: ShapeDecoration(
              gradient:  const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF08FFFF),
                  Color(0xFF007AFF),
                ],
                stops: [0.0016, 0.9245], // The stops can be adjusted as needed
                transform: GradientRotation(230.31 * (3.14159265358979323846 / 180)), // Converting degrees to radians
              ),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFD0E4FF)),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: const Icon(Icons.check, size: 12, color: Colors.white,),
          )  : const SizedBox()
        ],
      ).padding(const EdgeInsets.symmetric(vertical: 16)).onClick((){
        setState(() {
          if(selected.contains(color)){
            selected.remove(color);
          } else {
            selected.add(color);
          }
        });
        widget.onChange(selected);
      }),
    );
  }
}
