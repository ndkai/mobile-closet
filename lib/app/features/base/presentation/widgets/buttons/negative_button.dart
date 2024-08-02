import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';

class NegativeButton extends StatelessWidget {
  final double width;
  final double height;
  final String? label;
  final Function()? onTap;

  const NegativeButton(
      {super.key,
      required this.width,
      required this.height,
      required this.onTap, this.label});

  @override
  Widget build(BuildContext context) {
    return _buildButton();
  }

  Widget _buildButton() {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: ShapeDecoration(
        color: const Color(0xFFF2F6FA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child:  Center(
        child: Text(
          label ?? 'Cancel',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF014494),
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ).onClick(() => onTap!());
  }
}
