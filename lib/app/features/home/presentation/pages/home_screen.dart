

import 'dart:io';

import 'package:clean_architechture/app/features/base/presentation/widgets/buttons/positive_button.dart';
import 'package:clean_architechture/app/features/closet/manager/closet/closet_bloc.dart';
import 'package:clean_architechture/config/size/size_config.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:clean_architechture/core/models/scroll_behavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import '../../../../../core/commons/Ui.dart';
import '../../../../../core/services/di_service.dart';
import '../../../../../core/services/isar/schemas/closet.dart';
import '../../../../../generated/assets.dart';
import '../../../base/presentation/widgets/dialogs/new_closet_dialog_builder.dart';
import '../../../base/presentation/widgets/others/error_area.dart';
import '../../../base/presentation/widgets/text_field/custom_text_form_field.dart';
import '../../../closet/manager/clothes/clothes_bloc.dart';
import '../../../closet/pages/closet_screen.dart';
part '../widgets/local_home_screen/header.dart';
part '../widgets/local_home_screen/clothes_builder.dart';
part '../widgets/local_home_screen/category_builder.dart';
part '../widgets/local_home_screen/local_home_screen.dart';
part '../widgets/local_home_screen/recent.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key, });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const _LocalHomeScreen(header: _Header(), category: _Category(), clothes: _Clothes(), recent: _Recent(),);
  }
}
