import 'package:clean_architechture/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../share_widgets/card_enum.dart';
import '../models/enums/account_type.dart';
import '../models/enums/input_type.dart';

extension AccountTypeExtension on AccountType {
  String getName() {
    switch (this) {
      case AccountType.personal:
        return S.current.personalAccount;
      case AccountType.business:
        return S.current.businessAccount;
      default:
        return "";
    }
  }
}

extension InputTypeExtension on InputType {
  bool isValid(String text) {
    switch (this) {
      case InputType.email:
        return text.isEmail();
      case InputType.password:
        return text.isPassword();
      case InputType.name:
        return text.isName();
      case InputType.iban:
        return text.isIban();
      case InputType.swift:
        return text.isSwift();
      default:
        return true;
    }
  }

  String getErrorText() {
    switch (this) {
      case InputType.email:
        return S.current.emailNotCorrect;
      case InputType.password:
        return S.current.fieldRequire6Characters;
      case InputType.name:
        return S.current.fieldRequire6Characters;
      case InputType.phoneNumber:
        return S.current.phoneNotCorrect;
      case InputType.iban:
        return "Your IBAN is not correct";
      case InputType.swift:
        return "Your SWIFT is not correct";
      default:
        return "";
    }
  }
}

extension CardStatusEnumExtension on CardStatusEnum {
  static CardStatusEnum getCardStatusEnum(String? status) {
    switch (status) {
      case "Suspend":
        return CardStatusEnum.Suspend;
      case "Hold":
        return CardStatusEnum.Hold;
      case "Inactive":
        return CardStatusEnum.Inactive;
      case "Lost":
        return CardStatusEnum.Lost;
      case "Stolen":
        return CardStatusEnum.Stolen;
      case "Expired":
        return CardStatusEnum.Expired;
      case "Issued":
        return CardStatusEnum.Issued;
      case "Normal":
        return CardStatusEnum.Normal;
      default:
        throw CardStatusEnum.Unknow;
    }
  }

  Color mapStatusColor(CardStatusEnum? status) {
    switch (status) {
      case CardStatusEnum.Suspend:
        return Colors.orange;
      case CardStatusEnum.Hold:
        return Colors.orange;
      case CardStatusEnum.Inactive:
        return Colors.blue;
      case CardStatusEnum.Lost:
        return Colors.red;
      case CardStatusEnum.Stolen:
        return Colors.red;
      case CardStatusEnum.Expired:
        return Colors.red;
      case CardStatusEnum.Issued:
        return Colors.green;
      case CardStatusEnum.Normal:
        return const Color(0xFF007AFF);
      default:
        return Colors.blue;
    }
  }
}
