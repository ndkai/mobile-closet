import 'package:flutter/material.dart';

class PositiveButton extends StatelessWidget {
  final Function onTap;
  final double width;
  final double height;
  final bool enable;
  final String label;

  const PositiveButton(
      {super.key,
      required this.onTap,
      required this.width,
      required this.height,
      required this.label, this.enable = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(enable){
          onTap();
        }
 
      },
      child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            gradient: enable ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF08FFFF),
                Color(0xFF007AFF),
              ],
              stops: [0.0016, 0.9245], // The stops can be adjusted as needed
              transform: GradientRotation(230.31 * (3.14159265358979323846 / 180)), // Converting degrees to radians
            ) : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x2600A0DC),
                blurRadius: 10,
                offset: Offset(0, 6),
                spreadRadius: 0,
              )
            ],
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          )),
    );
  }
}
