
import 'package:clean_architechture/config/theme/theme.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:clean_architechture/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseArticleScreen extends StatefulWidget {
  final String title;
  final String url;
  final Widget child;
  final Function onShare;

  const BaseArticleScreen(
      {super.key,
      required this.title,
      required this.url,
      required this.child,
      required this.onShare});

  @override
  State<BaseArticleScreen> createState() => _BaseWebViewScreenState();
}

class _BaseWebViewScreenState extends State<BaseArticleScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leadingWidth: 200,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.white,
          title: Text(
            widget.title,
            style: AppTheme.currentTheme.textTheme.titleLarge,
          ),
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildButton(Icons.arrow_back_ios),
              Text(
                "Back",
                style: AppTheme.currentTheme.textTheme.titleMedium,
              )
            ],
          )
              .padding(const EdgeInsets.only(left: 16))
              .onClick(() => Navigator.of(context).pop()),
          actions: [
            SizedBox(
              height: 48,
              width: 20,
              child: SvgPicture.asset(Assets.iconsShare),
            )
                .padding(const EdgeInsets.only(right: 16))
                .onClick(() => widget.onShare())
          ],
        ),
        body: widget.child);
  }

  Widget _buildButton(IconData iconData) {
    return SizedBox(
      height: 48,
      width: 20,
      child: Icon(
        iconData,
        color: const Color(0xff014494),
      ),
    );
  }
}
