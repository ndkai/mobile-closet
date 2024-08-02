import 'package:clean_architechture/config/size/size_config.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../buttons/negative_button.dart';
import '../buttons/positive_button.dart';

class ConfirmDialogBuilder extends StatelessWidget {
  final String msg;
  final Widget description;
  final Function? onTap;
  final Function? onCancel;
  const ConfirmDialogBuilder({super.key, this.msg = "", this.onTap, required this.description, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: SizeConfig.screenWidth! * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Gap(10),
                Text(msg, style: const TextStyle(
                  color: Color(0xFF001F7B),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ), textAlign: TextAlign.center,),
                const Gap(20),
                description,
                const Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NegativeButton(width:  SizeConfig.screenWidth! * 0.3, height: 45, onTap: (){
                      if(onCancel != null){
                        onCancel!();
                      } else {
                        Navigator.pop(context);
                      }
                    }),
                    PositiveButton(onTap: (){
                      onTap!();
                    }, width: SizeConfig.screenWidth! * 0.3, height: 45, label: "Ok")
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}


class AlertDialogBuilder extends StatelessWidget {
  final String msg;
  final Widget description;
  final Function? onTap;
  const AlertDialogBuilder({super.key, this.msg = "", this.onTap, required this.description});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: SizeConfig.screenWidth! * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Gap(10),
                Text(msg, style: const TextStyle(
                  color: Color(0xFF001F7B),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ), textAlign: TextAlign.center,),
                const Gap(20),
                description.padding(const EdgeInsets.symmetric(horizontal: 4)),
                const Gap(30),
                const Divider(color: Colors.grey, thickness: .4,),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  width: SizeConfig.screenWidth,
                  child: const Center(
                    child: Text(
                      'Ok',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF001F7B),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ).onClick((){
                  if(onTap != null){
                    onTap!();
                  } else {
                    Navigator.of(context).pop();
                  }
                })
              ],
            ),
          ),
        )
    );
  }
}