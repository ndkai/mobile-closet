import 'package:clean_architechture/config/theme/theme.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/assets.dart';
import '../../../../../share_widgets/app_image.dart';

class SearchWidget extends StatelessWidget {
  final ValueChanged? onChanged;
  final ValueChanged? onSummited;
  final String? title;
  final double? width;
  final double? height;
  final TextEditingController? controller;

  const SearchWidget(
      {super.key,
      this.onChanged,
      this.onSummited,
      this.title,
      this.width,
      this.height, this.controller, });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        decoration: BoxDecoration(
            color: const Color(0xFFF2F6FA),
            borderRadius: BorderRadius.circular(8),
           ),
        child: Center(
          child: TextField(
            controller: controller,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            style: AppTheme.currentTheme.textTheme.titleMedium
                ?.merge(const TextStyle(color: Colors.blue)),
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                color: Color(0xFF9EA7B8),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
              hintText: title,
              prefixIcon: AppImage(
                image: Assets.iconsSearch,
                height: 3,
                width: 3,
                color: Colors.blue,
              ).padding(const EdgeInsets.all(10)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
            ),
            onChanged: onChanged,
            onSubmitted: onSummited,
          ),
        ));
  }

}