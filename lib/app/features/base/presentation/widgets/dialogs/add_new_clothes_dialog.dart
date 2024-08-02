import 'package:clean_architechture/core/commons/Ui.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../../../config/size/size_config.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../models/app_clothes.dart';
import '../buttons/positive_button.dart';

class AddNewClothesDialog extends StatefulWidget {
  const AddNewClothesDialog({super.key});

  @override
  State<AddNewClothesDialog> createState() => _AddNewClothesDialogState();
}

class _AddNewClothesDialogState extends State<AddNewClothesDialog> {

  int selectedSlider = 1;
  List<AppClothes> newClothes = <AppClothes>[];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16)
      ),
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Gap(16),
          Text("Add new clothes", style: GoogleFonts.montserratAlternates(
              textStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w700)
          )),
          const Gap(32),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _handleAddClothes(),
              const Gap(24),
              const _BuildCategories(),
              const Gap(16),
              PositiveButton(onTap: (){}, width: SizeConfig.screenWidth!, height: SizeConfig.screenWidth! * 0.12, label: "Confirm"),
              const Gap(16),
            ],
          )
        ],
      ),
    );
  }

  Widget _handleAddClothes(){
    if(newClothes.isNotEmpty){
      return Column(
        children: [
          // Text("$selectedSlider/${newClothes.length}", style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 12)), overflow: TextOverflow.ellipsis,),
          // const Gap(6),
          CarouselSlider(
            options: CarouselOptions(height: 200.0, onPageChanged: (i, _){
              setState(() {
                selectedSlider = i + 1;
              });
            }, enableInfiniteScroll: false),
            items: [
              ...newClothes.map((clothes) {
                return _imageBuilder(clothes);
              }),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.1),
                    borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(Assets.iconsAddNew,width: 30,),
                    const Gap(16),
                    Text("Add new", style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 12)), overflow: TextOverflow.ellipsis,)
                  ],
                )
              ).onClick((){UI.showChooseFileMethodsSheet(context, onChange: (value) {
                setState(() {
                  newClothes.addAll(value.map((e) => AppClothes(file: e, name: "", dateCreated: DateTime.now().toIso8601String(), controller: TextEditingController())));
                });
              });}),
            ]
          ),

        ],
      );
    }
    return  Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.withOpacity(.2)
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [Image.asset(Assets.iconsAddNew, width: 30,),
          const Gap(16),
          Text("Tap to add new clothes", style: GoogleFonts.poppins(
              textStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 12)
          )),],
      ),
    ).onClick((){
      UI.showChooseFileMethodsSheet(context, onChange: (value) {
       setState(() {
         newClothes.addAll(value.map((e) => AppClothes(file: e, name: "", dateCreated: DateTime.now().toIso8601String(), controller: TextEditingController())));
       });
      });
    });
  }

  Widget _imageBuilder(AppClothes clothes){
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 130,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.2),
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: FileImage(
                  clothes.file
              ))
          ),
          child: const CircleAvatar(
            radius: 14,
            backgroundColor: Colors.red,
            child: Center(
              child: Icon(Icons.close, size: 16, color: Colors.white,),
            ),
          ).align(Alignment.topRight).onClick((){
            setState(() {
              newClothes.remove(clothes);
            });
          }),
        ),
        const Gap(8),
        TextFormField(onChanged: (s){}, controller: clothes.controller, textAlign: TextAlign.center, decoration: const InputDecoration(
          hintText: "Give it a name",
        ), style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 12)),).padding(const EdgeInsets.symmetric(horizontal: 24))
      ],
    );
  }


}


class _BuildCategories extends StatefulWidget {
  const _BuildCategories({super.key});

  @override
  State<_BuildCategories> createState() => _BuildCategoriesState();
}

class _BuildCategoriesState extends State<_BuildCategories> {
  List<int> selectedIndexes = <int>[];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Choose categories", style: GoogleFonts.poppins(
            textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14)
        )).align(Alignment.centerLeft),
        const Gap(6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outlined, size: 14,),
            const Gap(3),
            Expanded(child: Text("All the images you choose will have the same categories", style: GoogleFonts.poppins(
                textStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w400, fontSize: 10)
            )))
          ],
        ),
        const Gap(6),
        Wrap(children: [0,1,2,3,4,5,6].map((e) => _buildCategoryItem(e)).toList())
      ],
    );
  }

  Widget _buildCategoryItem(int initIndex){
    return Column(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: selectedIndexes.contains(initIndex) ? Colors.grey : Colors.green,
          child: const Icon(Icons.add),
        ),
        const Gap(3),
        Text("Add new", style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 12)), overflow: TextOverflow.ellipsis,)
      ],
    ).padding(const EdgeInsets.symmetric(horizontal: 8, vertical: 8)).onClick((){
      setState(() {
        if( !selectedIndexes.contains(initIndex) ){
          selectedIndexes.add(initIndex);
        } else {
          selectedIndexes.remove(initIndex);
        }

      });
    });
  }
}

