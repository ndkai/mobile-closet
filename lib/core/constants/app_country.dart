

import 'package:clean_architechture/config/router/routes.dart';
import 'package:go_router/go_router.dart';

import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../models/quickmenu.dart';

class QuickMenu{
  static final data = <QuickMenuItem>[
    QuickMenuItem(img: Assets.iconsFeesandcharges,label: S.current.fAndC, angle: 342, navigate: (context) {
      context.push(AppRoutes.settingFeatureScreen, extra: "fees");
    }),
    QuickMenuItem(img: Assets.iconsFaqs, label: S.current.faqs, angle: 54, navigate: (context){
      context.push(AppRoutes.faqScreen);
    }),
    QuickMenuItem(img: Assets.iconsPhone, label: S.current.contactUs, angle: 126, navigate: (context,){
      context.push(AppRoutes.contactUs);
    }),
    QuickMenuItem(img: Assets.assetsIconsUserGuide, label: S.current.userGuide, angle: 198, navigate: (context){
      context.push(AppRoutes.settingFeatureScreen, extra: "userguide");
    }),
    QuickMenuItem(img: Assets.iconsInfo, label: S.current.aboutUs, angle: 270, navigate: (context){
      context.push(AppRoutes.settingFeatureScreen, extra: "aboutus");
      }),
  ];
}