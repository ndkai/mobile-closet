import 'dart:io';

import 'package:clean_architechture/app/features/base/presentation/widgets/buttons/positive_button.dart';
import 'package:clean_architechture/app/features/closet/manager/category/category_bloc.dart';
import 'package:clean_architechture/app/features/closet/manager/clothes/clothes_bloc.dart';
import 'package:clean_architechture/config/size/size_config.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:clean_architechture/core/services/di_service.dart';
import 'package:clean_architechture/core/services/isar/schemas/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/commons/Ui.dart';
import '../../../../generated/assets.dart';

part '../widgets/local_item_screen/clothes.dart';
part '../widgets/local_item_screen/filter.dart';
part '../widgets/local_item_screen/local_closet_screen.dart';
part '../widgets/local_item_screen/delete_clothes_builder.dart';


class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LocalScreen(
      filter: _Filter(),
      clothes: _Clothes(),
      deleteClothesBuilder: _DeleteClothesBuilder(),
    );
  }
}
