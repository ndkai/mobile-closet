import 'dart:io';

import 'package:clean_architechture/app/features/base/presentation/widgets/text_field/custom_text_form_field.dart';
import 'package:clean_architechture/app/features/closet/manager/category/category_bloc.dart';
import 'package:clean_architechture/core/commons/Ui.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:clean_architechture/core/services/di_service.dart';
import 'package:clean_architechture/core/services/isar/schemas/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:toastification/toastification.dart';
import '../../../../../../config/size/size_config.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../models/app_clothes.dart';
import '../buttons/positive_button.dart';
import '../others/error_area.dart';

class AddNewCategoryDialog extends StatefulWidget {
  const AddNewCategoryDialog({super.key});

  @override
  State<AddNewCategoryDialog> createState() => _AddNewCategoryDialogState();
}

class _AddNewCategoryDialogState extends State<AddNewCategoryDialog> {
  int selectedSlider = 1;
  Category category = Category();
  File? image;
  final categoryNameEdt = TextEditingController();
  String error = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DIService.sl<CategoryBloc>(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: BlocConsumer<CategoryBloc, CategoryState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(16),
                Text("Add new category",
                    style: GoogleFonts.montserratAlternates(
                        textStyle: const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w700))),
                const Gap(32),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _handleAddCategory(),
                    const Gap(24),
                    CustomTextFormField(
                      label: 'Give it a name',
                      onChanged: (String value) {
                        category.name = value;
                      },
                      controller: categoryNameEdt,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(24),
                    ErrorArea(
                      text: error,
                    ),
                    const Gap(16),
                    PositiveButton(
                        onTap: () {
                          if (categoryNameEdt.text.isEmpty) {
                            setState(() {
                              error = "Please give it a name";
                            });
                          } else {
                            setState(() {
                              error = "";
                            });
                            category.name = categoryNameEdt.text;

                            context
                                .read<CategoryBloc>()
                                .add(CreateCategoryEvent(category));
                          }
                        },
                        width: SizeConfig.screenWidth!,
                        height: SizeConfig.screenWidth! * 0.12,
                        label: "Confirm"),
                    const Gap(16),
                  ],
                )
              ],
            );
          },
          listener: (context, state) {
            print("state ${state.isLoading}");
            if (state.isLoading) {
              UI.showLoadingDialog(context, color: null);
            } else {
              Navigator.of(context).pop();
              if (state.createError!) {
                setState(() {
                  error = 'Please try again later';
                });
                return;
              }
              Navigator.of(context).pop();
              UI.showSuccessToast(context, "Create category success");
            }
          },
        ),
      ),
    );
  }

  Widget _handleAddCategory() {
    if (image != null) {
      return _imageBuilder();
    }
    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.withOpacity(.1)),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Image.asset(
            Assets.iconsAddNew,
            width: 30,
          ),
          const Gap(16),
          Text("Tap to add category representation",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w700,
                      fontSize: 12))),
        ],
      ),
    ).onClick(() {
      UI.showChooseFileMethodsSheet(context, onChange: (value) {
        setState(() {
          image = value.first;
        });
      });
    });
  }

  Widget _imageBuilder() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 130,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.2),
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: FileImage(image!))),
          child: const CircleAvatar(
            radius: 14,
            backgroundColor: Colors.red,
            child: Center(
              child: Icon(
                Icons.close,
                size: 16,
                color: Colors.white,
              ),
            ),
          ).align(Alignment.topRight).onClick(() {
            setState(() {
              image = null;
            });
          }),
        ),
      ],
    );
  }
}
