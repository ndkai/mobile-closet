import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NetworkExtensionImage extends StatelessWidget {
  final double height;
  final double width;
  final String url;
  final BoxFit fit;
  final Widget? fallbackWidget;
  const NetworkExtensionImage({super.key, required this.height, required this.width, required this.url, this.fit = BoxFit.fill, this.fallbackWidget});

  @override
  Widget build(BuildContext context) {
    return _buildImage();
  }
  Widget _buildImage(){
    final extension = url.split(".").last.toLowerCase();
    print("extension $extension");
    switch(extension){
      case "png":
        return Image.network(url, width: width, height: height,fit: fit,);
      case "jpg":
        return Image.network(url, width: width, height: height,fit: fit,);
      case "jpeg":
        return Image.network(url, width: width, height: height,fit: fit,);
      case "svg":
        return SvgPicture.network(url, width: width, height: height, fit: fit,);
      default:
        return fallbackWidget ?? const SizedBox();
    }
  }
}
