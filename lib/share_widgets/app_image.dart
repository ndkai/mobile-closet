import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'loading_indicator.dart';

class AppImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  AppImage(
      {super.key,
      required this.image,
      this.width,
      this.height,
      this.fit,
      this.color});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (image.endsWith('.svg')) {
      return SvgPicture.asset(
        image,
        placeholderBuilder: (context) => const LoadingIndicatorAnimation(
          size: 24,
        ),
        height: height,
        width: width,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.color) : null,
        fit: fit ?? BoxFit.contain,
        cacheColorFilter: true,
      );
    } else {
      return Image.asset(
        image,
        fit: fit,
        width: width,
        height: height,
        color: color,
      );
    }
  }
}
