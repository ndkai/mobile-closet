import 'package:clean_architechture/config/size/size_config.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Slidable extends StatefulWidget {
  final Widget child;
  final List<Widget> additionWidgets;
  const Slidable({super.key, required this.child, required this.additionWidgets});

  @override
  State<Slidable> createState() => _SlidableState();
}

class _SlidableState extends State<Slidable> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [SizedBox(
            width: SizeConfig.screenWidth,
            child: widget.child,
          ), Row(
            children: [
              Container(width: 100, color: Colors.blue,),
              const Gap(8),
              Container(width: 100, color: Colors.blue,),
            ],
          )],
        ),
      ),
    );
  }

}

class SlidableItem extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final ScrollController controller;
  const SlidableItem({super.key, required this.child, required this.onTap, required this.controller});

  @override
  Widget build(BuildContext context) {
    return child.onClick((){
      onTap();
      controller.jumpTo(0);
    });
  }
}


