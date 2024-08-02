import 'package:clean_architechture/config/size/size_config.dart';
import 'package:flutter/material.dart';

import 'loading_indicator.dart';

class LoadingDialog extends StatelessWidget {
  final Color? color;
  const LoadingDialog({super.key, this.color });

  @override
  Widget build(BuildContext context) {
    return color == null ? Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        // color: color,
        child: const Center(
          child: LoadingIndicatorAnimation(),
        ),
      ),
    ) : Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: color,
        child: const Center(
          child: LoadingIndicatorAnimation(),
        ),
      ),
    );
  }
}
