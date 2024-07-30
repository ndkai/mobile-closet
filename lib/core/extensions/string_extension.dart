extension StringExtension on String{
  bool isEmail() {
    RegExp regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regExp.hasMatch(this);
  }

  bool isPassword(){
    return length >= 5;
  }

  bool isName(){
    return length >= 5;
  }

  bool isPhoneNumber(){
    return length >= 5;
  }

  bool isContainSpecialCharacters(){
    final pattern = RegExp(r'^[a-zA-Z0-9@#$%^*_\-=\.+\,/?]*$');
    return !pattern.hasMatch(this);
  }

  bool isIban(){
    if(isEmpty){
      return true;
    }
    final RegExp _ibanRegExp = RegExp(
      r'^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$',
      caseSensitive: false,
    );
    return _ibanRegExp.hasMatch(this);
  }

  bool isSwift(){
    final RegExp _swiftRegExp = RegExp(
      r'^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$',
      caseSensitive: false,
    );
    return _swiftRegExp.hasMatch(this);
  }

  String capitalize() {
    if (isEmpty) return "";
    return this[0].toUpperCase() + substring(1);
  }
}