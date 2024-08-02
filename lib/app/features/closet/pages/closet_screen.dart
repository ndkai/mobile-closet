import 'package:clean_architechture/config/size/size_config.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:clean_architechture/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../base/presentation/widgets/dialogs/add_new_category_dialog.dart';
import '../../base/presentation/widgets/dialogs/add_new_clothes_dialog.dart';

part '../widgets/local_closet_screen/local_closet_screen.dart';
part '../widgets/local_closet_screen/filter.dart';
part '../widgets/local_closet_screen/clothes.dart';

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
