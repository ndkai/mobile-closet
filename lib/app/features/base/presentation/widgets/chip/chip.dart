import 'package:clean_architechture/app/features/base/presentation/pages/base_back_screen.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';

class ChipAreaView extends StatefulWidget {
  final List<String> values;
  final bool canEdit;
  const ChipAreaView({super.key, required this.values, this.canEdit = true});

  @override
  State<ChipAreaView> createState() => _ChipAreaViewState();
}

class _ChipAreaViewState extends State<ChipAreaView> {
  List<String> selected = [];
  @override
  Widget build(BuildContext context) {
    return Wrap(

      children: widget.values.map(
          (i) => ChipView(onChanged: (bool value) {
            if(!widget.canEdit){
              return;
            }
            setState(() {
              if(value){
                selected.add(i.toString());
              } else {
                selected.remove(i.toString());
              }
            });
          }, title: "${i}", active: selected.contains(i.toString()),)
      ).toList());
  }
}

class ChipView extends StatelessWidget {
  final bool active;
  final String title;
  final ValueChanged<bool> onChanged;
  const ChipView({super.key, this.active = false, required this.onChanged, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onChanged(!active);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: !active ? Colors.black54 : Colors.blue)
        ),
        child: Text(title),
      ),
    );
  }
}

