import 'dart:io';

import 'package:clean_architechture/app/features/closet/manager/clothes/clothes_bloc.dart';
import 'package:clean_architechture/config/size/size_config.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:clean_architechture/core/services/isar/schemas/clothes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/commons/ui.dart';

class ClothesActionDialogBuilder extends StatelessWidget {
  final Clothes clothes;
  final BuildContext rootContext;
  const ClothesActionDialogBuilder({super.key, required this.clothes, required this.rootContext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: SizeConfig.screenWidth! * 0.8,
              height: SizeConfig.screenHeight! * 0.3,

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: FileImage(File(clothes.filePath ?? ""))
                  )
              ),
            ),
            const Gap(16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              width: SizeConfig.screenWidth! * 0.6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),color: Colors.black54
              ),
              child: Column(
                children: [
                  _buildAction("Edit", Icons.edit, onTap: (){}),
                  const Divider(color: Colors.blue,),
                  _buildAction("Share", Icons.share, onTap: (){}),
                  const Divider(color: Colors.blue,),
                  _buildAction("Favorite", Icons.favorite_border, onTap: (){}),
                  const Divider(color: Colors.blue,),
                  _buildAction("Delete", Icons.delete_outline,color: Colors.red, onTap: (){
                    UI.showAlertDialog(context, msg: "Alert",
                      description: Text("Are you sure to delete?", style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 14, color: Colors.black)
                    ),), onTap: (){
                          Navigator.pop(context);
                          rootContext.read<DeleteClothesBloc>().add(DeleteClothesEvent(clothes.id));
                        });

                  }),
                ],
              ),
            )
          ],
        ),
      ).onClick(() => Navigator.pop(context)),
    );
  }

  Widget _buildAction(String name, IconData icon, {required Function onTap, Color color = Colors.white }){
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: GoogleFonts.roboto(
            textStyle: TextStyle(fontSize: 14, color: color)
          ),),
          Icon(icon, color: color, size: 23,)
        ],
      ).padding(const EdgeInsets.symmetric(horizontal: 8, vertical: 2)),
    );
  }
}



