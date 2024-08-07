import 'package:clean_architechture/app/features/base/presentation/blocs/toggle_cubit.dart';
import 'package:clean_architechture/app/features/base/presentation/widgets/others/file_image.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:clean_architechture/core/services/isar/schemas/clothes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/services/di_service.dart';
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
