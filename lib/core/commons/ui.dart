import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../config/theme/theme.dart';
import '../../features/base/presentation/widgets/bottom_sheets/datetime_range_picker/datetime_range_picker_builder.dart';
import '../../features/base/presentation/widgets/dialogs/confirm_dialog_builder.dart';
import '../../features/base/presentation/widgets/dialogs/error_dialog.dart';
import '../../features/base/presentation/widgets/dialogs/loading_dialog.dart';
import '../../generated/l10n.dart';
import '../models/enums/country_get_type.dart';
import '../models/enums/statements.dart';

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

  static void showLostConnectionDialog(BuildContext context,
      {required Function action}) {
    UI.showErrorDialog(context,
        msg: "Unable to load data",
        description: "Please check your internet connection", onTap: () {
      action();
    });
  }

  static void showErrorDialog(BuildContext context,
      {String msg = "", String description = "", Function? onTap}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return ErrorDialog(
          msg: msg,
          onTap: onTap!,
          description: description,
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


  static  (Color, Color) getCardOrderColor(String status){
    Color  color = const Color(0xFFE58600);
    Color  bgColor = const Color(0xFFFFF4E5);
    switch (status) {
      case 'Approved':
        color = const Color(0xFF007AFF);
        bgColor = const Color(0xFFEDF5FF);
        break;
      case 'Processed':
        color = const Color(0xFF007D3A);
        bgColor = const Color(0xFFD7FAE0);
        break;
      case 'Rejected by DNBC':
        color = const Color(0xFFB5010A);
        bgColor = const Color(0xFFFFF0F1);
        break;
      case 'Rejected by InterCash':
        color = const Color(0xFFB5010A);
        bgColor = const Color(0xFFFFF0F1);
        break;
      case 'Pending':
        color = const Color(0xFFE58600);
        bgColor = const Color(0xFFFFF4E5);
        break;
    }
    return (color, bgColor);
  }
}
