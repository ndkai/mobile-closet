import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';

import '../../../../config/theme/theme.dart';

class BaseBackScreen extends StatelessWidget {
  final Widget child;
  final bool resizeToAvoidBottomInset;
  final String? centerTitle;
  final String? leftTitle;
  final Function onBack;

  const BaseBackScreen(
      {super.key,
      required this.child,
      this.resizeToAvoidBottomInset = false,
      this.centerTitle,
      required this.onBack,
      this.leftTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: Column(
          children: [
            SafeArea(child: Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xff001F7B),
                          ),
                          Text(
                            "Back",
                            style:
                            AppTheme.currentTheme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                      Visibility(
                        visible: leftTitle != null,
                        child: Text(
                          leftTitle ?? "",
                          style: AppTheme.currentTheme.textTheme.titleMedium,
                        ),
                      )
                    ],
                  ).onClick(() => onBack()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.transparent,
                      ),
                      Visibility(
                          visible: centerTitle != null,
                          child: Text(
                            centerTitle ?? "",
                            style: AppTheme.currentTheme.textTheme.titleLarge!
                                .merge(const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF001F7B),
                                fontWeight: FontWeight.bold)),
                          ))
                    ],
                  )
                ],
              ),
            )),
            Expanded(child: child)
          ],
        ),);
  }
}
