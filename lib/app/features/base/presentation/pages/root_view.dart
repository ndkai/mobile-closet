import 'package:clean_architechture/app/features/closet/pages/category_screen.dart';
import 'package:clean_architechture/config/router/routes.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/size/size_config.dart';
import '../../../../../config/theme/theme.dart';
import '../../../../../core/commons/Ui.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../../closet/pages/items_screen.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../widgets/bottom_nav/nav_bar.dart';
import '../widgets/bottom_nav/nav_item.dart';
import '../widgets/dialogs/confirm_dialog_builder.dart';

part '../widgets/local_root_view/local_root_view.dart';

class RootView extends StatelessWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return _LocalRootView(
      key: rootScreenKey,
    );
  }
}
