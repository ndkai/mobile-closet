import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../config/size/size_config.dart';
import '../../../../../../config/theme/theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../blocs/change_datacubit.dart';

class ClickableTextField extends StatelessWidget {
  final String hintText;
  final Widget suffixIcon;
  final Function action;
  final TextEditingController controller;
  final TextStyle? style;
  final ValueChanged<String>? onError;
  final bool allowEmpty;
  const ClickableTextField(
      {super.key,
      required this.hintText,
      required this.suffixIcon,
      required this.action, required this.controller, this.style, this.onError, this.allowEmpty = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => ChangeDataCubit(), child: BlocBuilder<ChangeDataCubit, dynamic>(
      builder: (context, state){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextFormField(
              controller: controller,
              enabled: false,
              style: style ?? AppTheme.currentTheme.textTheme.titleMedium!.merge(const TextStyle(
                  color: Color(0xFF007AFF))),
              decoration: InputDecoration(
                hintText: hintText,
                labelStyle: AppTheme.currentTheme.textTheme.bodyLarge!.merge(
                    const TextStyle(
                        color: Color(0xFF66AFFF), fontWeight: FontWeight.bold)),
                suffixIcon: suffixIcon,
                hintStyle: AppTheme.currentTheme.textTheme.titleMedium
                    ?.merge(const TextStyle(color: Color(0xFFBEC5D2))),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: AppTheme.currentTheme
                          .primaryColorLight), // Color of the bottom line when focused
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                  BorderSide(color: AppTheme.currentTheme.primaryColorLight),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide:
                  BorderSide(color: AppTheme.currentTheme.primaryColorLight),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.currentTheme.colorScheme.error),
                ),
                // errorBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: AppTheme.currentTheme.errorColor),
                // ),
              ),
              validator: (value) {
                if (value!.isEmpty && !allowEmpty) {
                  context.read<ChangeDataCubit>().change(S.current.fieldRequired);
                  if(onError != null){
                    onError!("error");
                  }
                  return null;
                }
                context.read<ChangeDataCubit>().change("");
                if(onError != null){
                  onError!("");
                }
                return null;
              },
              onSaved: (value) {
                // _name = value;
              },
            ).onClick(() {
              action();
            }),
            state != null && (state as String).isNotEmpty ? Container(
              width: SizeConfig.screenWidth,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 40,
              decoration: BoxDecoration(
                  color: const Color(0xFFF8E3E3).withOpacity(.5),
                  borderRadius: BorderRadius.circular(1)),
              child: Text(
                state,
                style: AppTheme.currentTheme.textTheme.bodySmall!
                    .merge(const TextStyle(color: Colors.red, overflow: TextOverflow.ellipsis)),
              ).align(Alignment.centerLeft),
            ) : const SizedBox( )
          ],
        );
      },
    ),);
  }
}
