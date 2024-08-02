import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class LoadingIndicatorAnimation extends StatelessWidget {
  final double? size;
  const LoadingIndicatorAnimation({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LoadingAnimationWidget.twoRotatingArc(
      color: Color(0xff4273c7),
      size: size ?? 55,
    );
  }
}
