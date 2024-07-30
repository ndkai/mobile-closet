import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../core/utils/hex_color.dart';

class LoadingIndicatorAnimation extends StatelessWidget {
  final double? size;
  const LoadingIndicatorAnimation({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LoadingAnimationWidget.twoRotatingArc(
      color: HexColor('#4273c7'),
      size: size ?? 55,
    );
  }
}
