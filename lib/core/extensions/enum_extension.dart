import 'package:clean_architechture/core/extensions/string_extension.dart';
import '../../generated/l10n.dart';
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

