import 'dart:io';

import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:clean_architechture/core/services/isar/schemas/clothes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

import '../../app/features/base/presentation/widgets/bottom_sheets/datetime_range_picker/datetime_range_picker_builder.dart';
import '../../app/features/base/presentation/widgets/buttons/negative_button.dart';
import '../../app/features/base/presentation/widgets/buttons/positive_button.dart';
import '../../app/features/base/presentation/widgets/dialogs/add_new_category_dialog.dart';
import '../../app/features/base/presentation/widgets/dialogs/add_new_clothes_dialog.dart';
import '../../app/features/base/presentation/widgets/dialogs/confirm_dialog_builder.dart';
import '../../app/features/base/presentation/widgets/dialogs/image_action_dialog.dart';
import '../../app/features/base/presentation/widgets/dialogs/input_dialog_builder.dart';
import '../../app/features/base/presentation/widgets/dialogs/loading_dialog.dart';
import '../../app/features/base/presentation/widgets/text_field/custom_text_form_field.dart';
import '../../config/size/size_config.dart';
import '../../config/theme/theme.dart';
import '../../generated/l10n.dart';

class UI {
  static void showDateTimePickerBottomSheet(BuildContext context,
      {required ValueChanged<DateTime> onChanged,
      DateTime? initDate,
      DateTime? minimumDate,
      DateTime? maximumDate,
      CupertinoDatePickerMode? mode,
      Widget? instruction}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => DateTimePickerBuilder(
            onChanged: onChanged,
            initDate: initDate,
            minimumDate: minimumDate,
            instruction: instruction,
            maximumDate: maximumDate,
            mode: mode));
  }

  static showInputFieldDialog(BuildContext context, {List<String>? addition, String title = "", String hint = "", required Function(String) onConfirm}){

    showDialog(context: context, builder: (context){
      return Dialog(
        child: InputFieldDialogBuilder(title: title, hint: hint, onConfirm: onConfirm, additions: addition ?? [],),
      );
    });
  }

  static void showUnsupportSnackbar() {
    Fluttertoast.showToast(
        msg: "This function is not supported yet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showSuccessToast(BuildContext context, String msg){
    toastification.show(
      context: context,
      title: Text(msg, style: GoogleFonts.poppins(

      ),),
      type: ToastificationType.success,
      autoCloseDuration: const Duration(seconds: 3),
      style: ToastificationStyle.flat,
    );
  }

  static void showLoadingDialog(BuildContext context,
      {Color? color = Colors.white}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return LoadingDialog(
          color: color,
        );
      },
    );
  }

  static void showConfirmDialog(BuildContext context,
      {String msg = "", Widget? description, Function? onTap}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return ConfirmDialogBuilder(
          msg: msg,
          onTap: onTap!,
          description: description ?? const SizedBox(),
        );
      },
    );
  }

  static Future<bool> onWillPop(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return ConfirmDialogBuilder(
          msg: S.current.areUSure,
          onCancel: (){
            Navigator.pop(context, false);
          },
          onTap: (){
            Navigator.pop(context, true);
          },
          description: Column(
            children: [
              Text(
                "To close DNBC app",
                style: AppTheme.currentTheme.textTheme.bodySmall!
                    .copyWith(color: Colors.black),
              ),
              Text(
                "${S.current.areUSure}?",
                style: AppTheme.currentTheme.textTheme.bodySmall!
                    .copyWith(color: Colors.black),
              ),
            ],
          ),
        );
      },
    ) ?? false;
  }


  static void showAlertDialog(BuildContext context,
      {String msg = "", Widget? description, Function? onTap}) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialogBuilder(
          msg: msg,
          onTap: onTap!,
          description: description ?? const SizedBox(),
        );
      },
    );
  }


  static Future<void> showCreateNewCategory(BuildContext context) async {
    await  showDialog(context: context, builder: (context){
      return const Dialog(
          child: AddNewCategoryDialog()
      );
    });
  }

  static Future<void> showCreateNewClothesDialog(BuildContext context, {int? closetId}) async {
    await  showDialog(context: context, builder: (context){
      return Dialog(
          child: AddNewClothesDialog(closetId: closetId)
      );
    });
  }
  
  static Future<void> showClothesActionDialog(BuildContext acontext, Clothes clothes) async {
    await showDialog(context: acontext, builder: (context){
      return ClothesActionDialogBuilder(clothes: clothes, rootContext: acontext,);
    });
  }

  static Future<void> showChooseFileMethodsSheet(BuildContext appContext, {required ValueChanged<List<File>> onChange}) async {
    await showCupertinoModalPopup(
      context: appContext,
      builder: (BuildContext context) =>
          CupertinoActionSheet(
            title: const Text(
              "Choose method",
              style: TextStyle(
                color: Color(0xFF141B31),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () async {
                  try{
                    UI.showLoadingDialog(context, color: null);
                    FilePickerResult? result =
                    await FilePicker.platform.pickFiles(allowMultiple: true,
                        type: FileType.custom,
                        allowedExtensions: ['jpg', 'png']).then((value){
                      if (value != null) {
                        // if(value.files.first.size < 5 * 1024 * 1024){
                        //   // setState(() {
                        //   //   files.addAll(value.paths.map((path) => File(path!)).toList());
                        //   // });
                        // } else {
                        //   // showErrorToast(context, S.current.maximumFileSize);
                        // }
                        onChange(value.paths.map((path) => File(path!)).toList());
                        // appContext.read<SwiftTransferParamsCubit>().requestInterTransferParams.files = files;
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                      return null;
                    });


                  } catch(e){
                    Navigator.of(context).pop();
                  }

                },
                child:  const Text(
                  'File',
                  style: TextStyle(
                    color: Color(0xFF141B31),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  try{
                    UI.showLoadingDialog(context, color: null);
                    final ImagePicker picker = ImagePicker();
                    await picker.pickMultiImage().then((images){
                      onChange(images.map((path) => File(path.path)).toList());
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
                  } catch(e){
                    Navigator.of(context).pop();
                  }

                },
                child: const Text(
                  'Photo',
                  style: TextStyle(
                    color: Color(0xFF141B31),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // CupertinoActionSheetAction(
              //   onPressed: () async {
              //     try{
              //       UI.showLoadingDialog(context, color: null);
              //       final ImagePicker picker = ImagePicker();
              //       await picker.pickImage(source: ImageSource.camera).then((image){
              //         onChange([File(image!.path)]);
              //                             Navigator.of(context).pop();
              //         Navigator.of(context).pop();
              //       });
              //     } catch(e){
              //       Navigator.of(context).pop();
              //     }
              //
              //   },
              //   child: const Text(
              //     'Camera',
              //     style: TextStyle(
              //       color: Color(0xFF141B31),
              //       fontSize: 16,
              //       fontFamily: 'Roboto',
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
            ],
            cancelButton: Container(
              color: Colors.white,
              child: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                isDefaultAction: true,
                child: Text(
                  S.current.cancel,
                  style: const TextStyle(
                    color: Color(0xFF141B31),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
