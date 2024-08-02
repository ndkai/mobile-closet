import 'package:clean_architechture/config/size/size_config.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:result_dart/result_dart.dart';

class Slidable extends StatefulWidget {
  final Widget child;
  final List<SlidableItem> additionItems;
  const Slidable({super.key, required this.child, required this.additionItems});

  @override
  State<Slidable> createState() => _SlidableState();
}

class _SlidableState extends State<Slidable> {
  final ScrollController scrollController = ScrollController();
  bool _isScrolling = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification){
          if (notification is ScrollEndNotification) {
            if(scrollController.offset > scrollController.position.maxScrollExtent * 0.6){
              WidgetsBinding.instance
                  .addPostFrameCallback((_){scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );});
            } else {
              WidgetsBinding.instance
                  .addPostFrameCallback((_){scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );});
            }
          }
          return false;
        },
        child: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [SizedBox(
              width: SizeConfig.screenWidth,
              child: widget.child,
            ), Row(
              children: widget.additionItems.map((e) => Column(
                children: [
                  const Gap(8),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: e.color
                    ),
                    child: Column(
                      children: [
                        Icon(e.icon, color: Colors.white,),
                        const Gap(3),
                        Text(e.name, style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 13)), overflow: TextOverflow.ellipsis,)
                      ],
                    ),
                  ),
                  const Gap(8),
                ],
              )).toList(),
            )],
          ),
        ),
      ),
    );
  }

}

class SlidableItem{
  final String name;
  final IconData icon;
  final Function onTap;
  final Color color;

  SlidableItem( {required this.color,required this.name, required this.icon, required this.onTap});
}


