import 'dart:io';

import 'package:clean_architechture/app/features/base/presentation/pages/base_back_screen.dart';
import 'package:clean_architechture/app/features/clothes/pages/clothes_details_screen.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:clean_architechture/core/services/isar/schemas/closet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/size/size_config.dart';
import '../../../../core/commons/ui.dart';
import '../../../../core/services/di_service.dart';
import '../../../../core/services/isar/schemas/category.dart';
import '../../../../generated/assets.dart';
import '../../base/presentation/widgets/buttons/positive_button.dart';
import '../manager/category/category_bloc.dart';
import '../manager/clothes/clothes_bloc.dart';

part '../widgets/local_closet_screen/local_screen.dart';
part '../widgets/local_closet_screen/clothes.dart';
part '../widgets/local_closet_screen/filter.dart';

class ClosetScreen extends StatelessWidget {
  final Closet closet;
  const ClosetScreen({super.key, required this.closet});

  @override
  Widget build(BuildContext context) {
    return _LocalScreen(closet: closet,);
  }
}
