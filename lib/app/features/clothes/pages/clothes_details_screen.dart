import 'dart:io';

import 'package:clean_architechture/app/features/base/presentation/blocs/toggle_cubit.dart';
import 'package:clean_architechture/app/features/base/presentation/widgets/others/file_image.dart';
import 'package:clean_architechture/app/features/base/presentation/widgets/text_field/custom_text_form_field.dart';
import 'package:clean_architechture/app/features/closet/manager/clothes_details/clothes_details_bloc.dart';
import 'package:clean_architechture/config/size/size_config.dart';
import 'package:clean_architechture/core/commons/constant.dart';
import 'package:clean_architechture/core/commons/helper.dart';
import 'package:clean_architechture/core/commons/ui.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:clean_architechture/core/services/isar/schemas/clothes.dart';
import 'package:clean_architechture/core/services/isar/schemas/clothes_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
// import 'package:image_editor_plus/utils.dart';

import '../../../../core/commons/date_time_utils.dart';
import '../../../../core/services/di_service.dart';
import '../../base/presentation/widgets/bottom_sheets/material_sheet_builder.dart';
import '../../base/presentation/widgets/buttons/negative_button.dart';
import '../../base/presentation/widgets/buttons/positive_button.dart';
import '../../base/presentation/widgets/dialogs/color_picker.dart';
import '../../closet/manager/clothes/clothes_bloc.dart';

part '../widgets/local_clothes_details_screen/local_clothes_details_screen.dart';
part '../widgets/local_clothes_details_screen/filter.dart';
part '../widgets/local_clothes_details_screen/outfit.dart';
part '../widgets/local_clothes_details_screen/information_builder.dart';
class ClothesDetailsScreen extends StatelessWidget {
  final Clothes clothes;
  const ClothesDetailsScreen({super.key, required this.clothes});

  @override
  Widget build(BuildContext context) {
    return _LocalScreen(clothes: clothes,);
  }
}
