import 'package:clean_architechture/app/features/base/presentation/pages/base_back_screen.dart';
import 'package:clean_architechture/app/features/closet/manager/category/category_bloc.dart';
import 'package:clean_architechture/config/size/size_config.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:clean_architechture/core/services/di_service.dart';
import 'package:clean_architechture/core/services/isar/schemas/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../generated/assets.dart';
import '../../base/presentation/widgets/dialogs/add_new_category_dialog.dart';
import '../../base/presentation/widgets/slidable_widget/slidable.dart';
part '../widgets/local_category_screen/local_category_screen.dart';
class CategoryManageScreen extends StatelessWidget {
  const CategoryManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _LocalCategoryScreen(

    );
  }
}
