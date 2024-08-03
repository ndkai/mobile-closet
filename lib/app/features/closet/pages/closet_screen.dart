import 'dart:io';

import 'package:clean_architechture/app/features/closet/manager/category/category_bloc.dart';
import 'package:clean_architechture/app/features/closet/manager/clothes/clothes_bloc.dart';
import 'package:clean_architechture/config/size/size_config.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:clean_architechture/core/services/di_service.dart';
import 'package:clean_architechture/core/services/isar/schemas/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/commons/Ui.dart';

part '../widgets/local_closet_screen/clothes.dart';
part '../widgets/local_closet_screen/filter.dart';
part '../widgets/local_closet_screen/local_closet_screen.dart';

class ClosetScreen extends StatelessWidget {
  const ClosetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LocalScreen(
      filter: _Filter(),
      clothes: _Clothes()
    );
  }
}
