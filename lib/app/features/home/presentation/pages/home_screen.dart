

import 'package:clean_architechture/config/size/size_config.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import '../../../../../core/services/di_service.dart';
import '../../../../../generated/assets.dart';
import '../../../closet/manager/clothes/clothes_bloc.dart';
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
