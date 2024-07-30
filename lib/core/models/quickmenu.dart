import 'package:flutter/cupertino.dart';

class QuickMenuItem {
  final String img;
  final Function(BuildContext) navigate;
  final String label;
  final double angle;

  QuickMenuItem({required this.navigate, required this.angle, required this.img, required this.label});
}