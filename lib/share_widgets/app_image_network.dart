
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../generated/assets.dart';
import 'loading_indicator.dart';

class AppImageNetwork extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  const AppImageNetwork(
      {super.key,
      required this.url,
      this.width,
      this.height,
      this.fit,
      this.color,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (url.endsWith('.svg')) {
      return SvgPicture.network(
        url,
        placeholderBuilder: (context) => const LoadingIndicatorAnimation(),
        height: height,
        width: width,
        color: color,
        fit: fit ?? BoxFit.contain,
      );
    } else {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) => Skeletonizer(enabled: true,child: Image.asset(Assets.imagesBackground, fit: BoxFit.fitWidth,),),
          errorWidget: (context, url, error) => Image.asset(Assets.imagesBackground, fit: BoxFit.fitWidth,),
          height: height,
          width: width,
          color: color,
          fit: fit ?? BoxFit.contain,
        ),
      );
    }
  }
}
