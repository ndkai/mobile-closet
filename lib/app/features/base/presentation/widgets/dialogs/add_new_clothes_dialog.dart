import 'dart:async';
import 'dart:io';

import 'package:clean_architechture/app/features/base/presentation/widgets/otp_pin_field/otp_pin_field.dart';
import 'package:clean_architechture/app/features/closet/manager/category/category_bloc.dart';
import 'package:clean_architechture/app/features/closet/manager/clothes/clothes_bloc.dart';
import 'package:clean_architechture/core/commons/Ui.dart';
import 'package:clean_architechture/core/commons/helper.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:clean_architechture/core/services/di_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../../../config/size/size_config.dart';
import '../../../../../../core/services/isar/schemas/category.dart';
import '../../../../../../core/services/isar/schemas/clothes.dart';
import '../../../../../../generated/assets.dart';
import '../buttons/positive_button.dart';
import '../others/error_area.dart';

class AddNewClothesDialog extends StatefulWidget {
  final int? closetId;
  const AddNewClothesDialog({super.key, this.closetId});

  @override
  State<AddNewClothesDialog> createState() => _AddNewClothesDialogState();
}

class _AddNewClothesDialogState extends State<AddNewClothesDialog> {
  int selectedSlider = 1;
  List<Clothes> newClothes = [];
  List<File> images = [];
  String error = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DIService.sl<CreateClothesBloc>(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(16),
            Text("Add new clothes",
                style: GoogleFonts.montserratAlternates(
                    textStyle: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w700))),
            const Gap(32),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _handleAddClothes(),
                const Gap(8),
                ErrorArea(
                  text: error,
                ),
                const Gap(24),
                // _BuildCategories(
                //   onChange: (List<int> value) {
                //     newClothes.categories = value;
                //   }, onChangeName: (List<String> value) {
                //   newClothes.categoriesName = value;
                // },
                // ),
                const Gap(16),
                BlocConsumer<CreateClothesBloc, ClothesState>(
                    builder: (context, state) {
                      return PositiveButton(
                          onTap: () async {
                            if(images.isEmpty){
                              setState(() {
                                error = "At least you should choose an image";
                              });
                              return;
                            }
                            setState(() {
                              error = "";
                            });
                            UI.showLoadingDialog(context, color: null);
                            final completer = _UpdateClothesCompleter(() async {
                              for(var i = 0; i < newClothes.length; i++){
                                // newClothes[i].filePath = await Helper.saveFile("clothes",images[i].path.split("/").last, images[i]);
                                if(widget.closetId != null){
                                  if(newClothes[i].closetId == null){
                                    newClothes[i].closetId = [widget.closetId ?? -1];
                                  } else {
                                    newClothes[i].closetId!.add(widget.closetId ?? -1);
                                  }

                                }
                                context.read<CreateClothesBloc>().add(CreateClothesEvent(newClothes[i]));

                              }
                            })..init();
                            await completer.isReady.then((value) async {
                              await Future.delayed(const Duration(seconds: 1));
                              Navigator.pop(context);Navigator.pop(context);
                            });

                          },
                          width: SizeConfig.screenWidth!,
                          height: SizeConfig.screenWidth! * 0.12,
                          label: "Confirm");
                    },
                    listener: (context, state) {
                      if(state is ClothesCreateSuccessState){
                        // UI.showSuccessToast(context, "Create clothes successfully");
                      }
                    }),
                const Gap(16),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _handleAddClothes() {
    if (images.isNotEmpty) {
      return Column(
        children: [
          // Text("$selectedSlider/${newClothes.length}", style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 12)), overflow: TextOverflow.ellipsis,),
          // const Gap(6),
          _imageBuilder()
        ],
      );
    }
    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.withOpacity(.2)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        children: [
          Image.asset(
            Assets.iconsAddNew,
            width: 30,
          ),
          const Gap(16),
          Text("Tap to add new clothes",
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
          newClothes.addAll(value.map((e) => Clothes()..filePath = e.path).toList());
          images = value;
        });
      });
    });
  }

  Widget _imageBuilder() {
    return Column(
      children: [
        CarouselSlider(items: images.map((e) => Container(
          width: MediaQuery.of(context).size.width,
          height: 130,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.2),
              borderRadius: BorderRadius.circular(8),
              image:
              DecorationImage(image: FileImage(e))),
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
              // newClothes.remove(value) = null;
              // image = null;
            });
          }),
        )).toList(), options: CarouselOptions(),),

        // const Gap(8),
        // TextFormField(onChanged: (s){}, controller: clothes.controller, textAlign: TextAlign.center, decoration: const InputDecoration(
        //   hintText: "Give it a name",
        // ), style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 12)),).padding(const EdgeInsets.symmetric(horizontal: 24))
      ],
    );
  }
}

class _BuildCategories extends StatefulWidget {
  final ValueChanged<List<int>> onChange;
  final ValueChanged<List<String>> onChangeName;

  const _BuildCategories({super.key, required this.onChange, required this.onChangeName});

  @override
  State<_BuildCategories> createState() => _BuildCategoriesState();
}

class _BuildCategoriesState extends State<_BuildCategories> {
  List<int> selectedIndexes = <int>[];
  List<String> selectedName = <String>[];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  DIService.sl<GetCategoryBloc>()..add(GetCategoriesEvent()))
        ],
        child: Column(
          children: [
            Text("Choose categories",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 14)))
                .align(Alignment.centerLeft),
            const Gap(6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outlined,
                  size: 14,
                ),
                const Gap(3),
                Expanded(
                    child: Text(
                        "You can choose multi categories for your clothes",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w400,
                                fontSize: 10))))
              ],
            ),
            const Gap(6),
            BlocBuilder<GetCategoryBloc, CategoryState>(
                builder: (context, state) {
              if (state is CategoryGetSuccessState) {
                return Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: state.categories
                        .map((e) => _buildCategoryItem(e))
                        .toList());
              }
              return  Text("No categories",
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700)));
            })
          ],
        ));
  }

  Widget _buildCategoryItem(Category category) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          // color: selectedIndexes.contains(category.id) ? Colors.green : Colors.blue,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          CircleAvatar(
            radius: 22,
            // backgroundColor: selectedIndexes.contains(category.id) ? Colors.grey : Colors.green,
            backgroundImage: FileImage(File(category.filePath!)),
          ),
          const Gap(3),
          Text(
            category.name ?? "",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 12,
                    color: selectedIndexes.contains(category.id)
                        ? Colors.green
                        : Colors.black)),
            overflow: TextOverflow.ellipsis,
          )
        ],
      )
          .padding(const EdgeInsets.symmetric(horizontal: 8, vertical: 8))
          .onClick(() {
        setState(() {
          if (!selectedIndexes.contains(category.id)) {
            selectedIndexes.add(category.id);
            selectedName.add(category.name??"");
          } else {
            selectedIndexes.remove(category.id);
            selectedName.remove(category.name);
          }
          widget.onChange(selectedIndexes);
          widget.onChangeName(selectedName);
        });
      }),
    );
  }
}


class _UpdateClothesCompleter{
  final Function action;

  _UpdateClothesCompleter(this.action);

  final Completer<bool> _comp = Completer<bool>();

  Future<bool> get isReady => _comp.future;

  Future<void> init() async {
    final result = await action();
    _comp.complete(true);
  }
}