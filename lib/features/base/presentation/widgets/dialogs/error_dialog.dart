import 'package:clean_architechture/config/size/size_config.dart';
import 'package:clean_architechture/features/base/presentation/widgets/buttons/positive_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../../config/theme/theme.dart';
import '../../../../../generated/assets.dart';

class ErrorDialog extends StatelessWidget {
  final String msg;
  final String description;
  final Function? onTap;
  const ErrorDialog({super.key, this.msg = "", this.onTap, required this.description});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Center(
        child: SizedBox(
          width: 343,
          height: 282,
          child: Stack(
            children: [
              Container(
                  width: 343,
                  height: 282,
                  padding: const EdgeInsets.only(
                    top: 80,
                    left: 24,
                    right: 24,
                    bottom: 30,
                  ),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        msg,
                        style: AppTheme.currentTheme.textTheme.titleLarge
                            ?.merge(const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const Gap(20),
                      Text(
                        description.isEmpty ? "Please try again later or contact support" : description,
                        textAlign: TextAlign.center,
                        style: AppTheme.currentTheme.textTheme.bodyMedium
                            ?.merge(const TextStyle(color: Colors.black)),
                      ),
                      const Spacer(),
                      PositiveButton(onTap: (){
                        onTap!();
                      }, width: SizeConfig.screenWidth!, height: 50, label: "OK"),
                    ],
                  )
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Transform.translate(
                  offset: const Offset(0, -50),
                  child: SvgPicture.asset(Assets.statementsFailed),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

}
