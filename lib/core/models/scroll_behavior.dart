import 'package:flutter/material.dart';

class NoScrollIndicatorBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child; // Remove the scroll indicator
  }
}