import 'dart:io';

import 'package:clean_architechture/app/features/base/presentation/widgets/buttons/positive_button.dart';
import 'package:clean_architechture/app/features/base/presentation/widgets/text_field/header_textfield.dart';
import 'package:clean_architechture/config/size/size_config.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../../config/theme/theme.dart';
import '../../../base/presentation/widgets/chip/chip.dart';

class OutfitInputInfoScreen extends StatelessWidget {
  final String? filePath;

  const OutfitInputInfoScreen({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.all(16),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.blue,
          ),
        ).onClick(() => Navigator.of(context).pop()),
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Your outfit",
          style: GoogleFonts.montserratAlternates(
              textStyle: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.w700)),
        ),
        actions: const [
          // Text(
          //   "Next",
          //   style: GoogleFonts.montserratAlternates(
          //       textStyle: const TextStyle(
          //           color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 16)),
          // ).onClick((){
          //   Helper.saveScreenShot(screenshotController, "outfit");
          // }),
          Gap(16)
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          Image.file(
            File(filePath!),
            width: SizeConfig.screenWidth,
          ),
          Container(
            margin: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.4),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.3),
                      offset: const Offset(0, -3))
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            width: SizeConfig.screenWidth,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  HeaderTextField(
                      title: "Outfit name",
                      hint: "Input your lovely name",
                      valueChanged: (s) {}),
                  _OutfitOccasionView(),
                  HeaderTextField(
                      title: "Description",
                      hint: "Description about your outfit",
                      valueChanged: (s) {}),

                  const Gap(50),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: PositiveButton(
                    onTap: () {},
                    width: SizeConfig.screenWidth!,
                    height: 50,
                    label: "Done")
                .padding(const EdgeInsets.symmetric(horizontal: 16)),
          )
        ],
      )),
    );
  }
}

class _OutfitOccasionView extends StatelessWidget {
  const _OutfitOccasionView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Gap(20),
          Text(
            "Occasion",
            style: AppTheme.currentTheme.textTheme.titleSmall!
                .merge(const TextStyle(color: Colors.black)),
          ),
          const Gap(10),
          ChipAreaView(values: [],),
        ],
      ),
    ).onClick((){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: SizeConfig.screenWidth,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(30),
                //style
                Text(
                  "Style",
                  style: AppTheme.currentTheme.textTheme.titleSmall!
                      .merge(const TextStyle(color: Colors.black)),
                ),
                const Gap(10),
                const ChipAreaView(values: [
                  "formal",
                  "casual",
                  "trendy",
                  "modern",
                  "artistic",
                  "dress-up",
                ],),
                const Gap(16),
                //occasion
                Text(
                  "Occasion",
                  style: AppTheme.currentTheme.textTheme.titleSmall!
                      .merge(const TextStyle(color: Colors.black)),
                ),
                const Gap(10),
                const ChipAreaView(values: [
                  "daily",
                  "work",
                  "school",
                  "travel",
                  "sport",
                  "party",
                  "dating",
                  "beach",
                  "mountain",
                  "event",
                ],),
                const Gap(16),
                //season
                Text(
                  "Season",
                  style: AppTheme.currentTheme.textTheme.titleSmall!
                      .merge(const TextStyle(color: Colors.black)),
                ),
                const Gap(10),
                const ChipAreaView(values: [
                  "Spring",
                  "Summer",
                  "Fall",
                  "Winter",
                ],),
                const Gap(40),
              ],
            ),
          ),
        );
      });
    });
  }
}

