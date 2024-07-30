import 'package:clean_architechture/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class NavItem extends StatelessWidget {
  final String img;
  final String label;
  final bool isActive;

  const NavItem(
      {super.key,
      required this.img,
      required this.label,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(30),
        SvgPicture.asset(
          img,
          width: 18,
          height: 20,
        ),
        const Gap(3),
        Text(
          label,
          style: AppTheme.currentTheme.textTheme.bodySmall!.merge(TextStyle(
              color: isActive ? const Color(0xFF014494) : Colors.black)),
        )
      ],
    );
  }
}
