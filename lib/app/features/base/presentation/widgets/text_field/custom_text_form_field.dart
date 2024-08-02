import 'package:clean_architechture/core/extensions/enum_extension.dart';
import 'package:clean_architechture/core/extensions/string_extension.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:clean_architechture/core/models/enums/input_type.dart';
import 'package:clean_architechture/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../config/size/size_config.dart';
import '../../../../../../config/theme/theme.dart';
import '../../../../../../generated/assets.dart';
import '../../../../base/presentation/blocs/toggle_cubit.dart';
import '../../blocs/change_datacubit.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String? customErrorText;
  final Function(String, BuildContext)? validatorDelegate;
  final Widget? suffixIcon;
  final bool enable;
  final TextEditingController controller;
  final int? maxLines;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onTap;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onTapOutSide;
  final ValueChanged<String>? onValidateError;
  final bool allowEmpty;
  final int? maxLength;
  final InputType? inputType;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final bool allowSpecialCharacters;
  final TextInputType? textInputType;

  const CustomTextFormField({super.key, required this.label, this.suffixIcon, this.enable = true, this.maxLines = 1, required this.onChanged, required this.controller, this.inputType = InputType.plainText, this.allowEmpty = false, this.onCompleted, this.textStyle, this.textInputType, this.onTapOutSide, this.onTap, this.customErrorText, this.validatorDelegate, this.allowSpecialCharacters = true, this.maxLength, this.onValidateError, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => ChangeDataCubit(), child: BlocBuilder<ChangeDataCubit, dynamic>(
      builder: (context, state){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextFormField(
              enabled: enable,
              controller: controller,
              maxLines: maxLines,
              textAlign: textAlign??TextAlign.start,
              keyboardType: textInputType,
              onTapOutside: (_){
                if(onTapOutSide != null){
                  onTapOutSide!(controller.text);
                }

              },
              style: textStyle ?? AppTheme.currentTheme.textTheme.titleMedium!
                  .merge(const TextStyle(color: Color(0xFF007AFF))),
              decoration: InputDecoration(
                hintText: label,
                suffixIcon: suffixIcon,
                labelStyle: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Color(0xFF007AFF))),
                hintStyle: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: Color(0xFFBEC5D2))),
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
                  borderSide:
                  BorderSide(color: AppTheme.currentTheme.colorScheme.error),
                ),
              ),
              onChanged: onChanged,
              onTap: (){
                if(onTap != null){
                  onTap!("");
                }
              },
              onEditingComplete: (){
                if(onCompleted != null){
                  onCompleted!(controller.text);
                }

              },
              validator: (value) {
                if(maxLength != null){
                  if(value!.length > maxLength!){
                    context.read<ChangeDataCubit>().change("This field cannot exceeds $maxLength characters");
                    onChanged("");
                    if(onValidateError != null){
                      onValidateError!("error");
                    }
                    return null;
                  }
                }
                if(!allowSpecialCharacters){
                  if(value!.isContainSpecialCharacters()){
                    context.read<ChangeDataCubit>().change("This field contain special characters");
                    onChanged("");
                    if(onValidateError != null){
                      onValidateError!("error");
                    }
                    return null;
                  }
                }
                if(validatorDelegate == null){
                  if(!allowEmpty){
                    if(value!.isEmpty){
                      context.read<ChangeDataCubit>().change(S.current.fieldRequired);
                      if(onValidateError != null){
                        onValidateError!("error");
                      }
                      return null;
                    }
                  }
                  if(!inputType!.isValid(value!)){
                    context.read<ChangeDataCubit>().change(customErrorText ?? inputType!.getErrorText());
                    onChanged("");
                    if(onValidateError != null){
                      onValidateError!("error");
                    }
                    return null;
                  }
                } else {
                  validatorDelegate!(value ?? "", context);
                  onChanged("");

                  return null;
                }  if(onValidateError != null){
                  onValidateError!("");
                }
                context.read<ChangeDataCubit>().change("");
                return null;

              },
              onSaved: (value) {
                // _name = value;
              },
            ),
            state != null && (state as String).isNotEmpty  ? Container(
              width: SizeConfig.screenWidth,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 40,
              decoration: BoxDecoration(
                  color: const Color(0xFFF8E3E3).withOpacity(.5),
                  borderRadius: BorderRadius.circular(1)),
              child: Text(
                state,
                style: AppTheme.currentTheme.textTheme.bodySmall!
                    .merge(const TextStyle(color: Colors.red, )),
              ).align(Alignment.centerLeft),
            ) : const SizedBox( )
          ],
        );
      },
    ),);
  }
}

class PasswordTextFormField extends StatelessWidget {
  final String label;
  final Widget? suffixIcon;
  final bool enable;
  final bool allowSpecialCharacters;
  final int? maxLength;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final TextInputType? inputType;
  const PasswordTextFormField(
      {super.key,
        required this.label,
        this.suffixIcon,
        this.enable = true,
        required this.onChanged, this.allowSpecialCharacters = false, this.maxLength, this.controller, this.inputType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => ChangeDataCubit(), child: BlocBuilder<ChangeDataCubit, dynamic>(
      builder: (context, state){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            BlocProvider(
                create: (_) => ToggleCubit(),
                child: BlocBuilder<ToggleCubit, bool>(
                  builder: (context, isToggled) {
                    return TextFormField(
                      enabled: enable,
                      keyboardType: inputType,
                      controller: controller,
                      obscureText: !isToggled,
                      style: AppTheme.currentTheme.textTheme.titleMedium!
                          .merge(const TextStyle(color: Color(0xFF007AFF))),
                      decoration: InputDecoration(
                        hintText: label,

                        suffixIcon: (isToggled
                            ? const Icon(Icons.remove_red_eye_outlined,
                            color: Colors.blue)
                            : (Image.asset(Assets.iconsHome,
                            width: 1, color: Colors.blue)
                            .padding(const EdgeInsets.all(5))))
                            .onClick(() => context.read<ToggleCubit>().toggle()),
                        labelStyle: AppTheme.currentTheme.textTheme.bodyLarge!.merge(
                            const TextStyle(
                                color: Color(0xFF007AFF), fontWeight: FontWeight.bold)),
                        hintStyle: AppTheme.currentTheme.textTheme.titleMedium
                            ?.merge(const TextStyle(color: Color(0xFFBEC5D2))),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppTheme.currentTheme
                                  .primaryColorLight), // Color of the bottom line when focused
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppTheme.currentTheme.primaryColorLight),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppTheme.currentTheme.primaryColorLight),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppTheme.currentTheme.colorScheme.error),
                        ),
                      ),
                      onChanged: onChanged,
                      validator: (value) {
                        if(maxLength != null){
                          if(value!.length > maxLength!){
                            context.read<ChangeDataCubit>().change("This field cannot exceeds $maxLength characters");
                            onChanged("");
                            return null;
                          }
                        }
                        if(!allowSpecialCharacters){
                          if(value!.isContainSpecialCharacters()){
                            context.read<ChangeDataCubit>().change("This field contain special characters");
                            onChanged("");
                            return null;
                          }
                        }
                        InputType inputType = InputType.password;
                        if (value!.isEmpty) {
                          context.read<ChangeDataCubit>().change(S.current.fieldRequired);
                          onChanged("");
                          return null;
                        }
                        if (!inputType.isValid(value)) {
                          context.read<ChangeDataCubit>().change(inputType.getErrorText());
                          onChanged("");
                          return null;
                        }
                        context.read<ChangeDataCubit>().change("");
                        return null;
                      },
                      onSaved: (value) {
                        // _name = value;
                      },
                    );
                  },
                )),
            state != null && (state as String).isNotEmpty  ? Container(
              width: SizeConfig.screenWidth,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 40,
              decoration: BoxDecoration(
                  color: const Color(0xFFF8E3E3).withOpacity(.5),
                  borderRadius: BorderRadius.circular(1)),
              child: Text(
                state,
                style: AppTheme.currentTheme.textTheme.bodySmall!
                    .merge(const TextStyle(color: Colors.red, )),
              ).align(Alignment.centerLeft),
            ) : const SizedBox( )
          ],
        );
      },
    ),);
  }
}
