import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
class Helper{

  static bool isTokenExpired(int expiryTimestamp) {
    DateTime expiryTime = DateTime.fromMillisecondsSinceEpoch(expiryTimestamp * 1000);
    print("expiryTime ${expiryTime.toString()}");
    return expiryTime.isBefore(DateTime.now());
  }



  static String formatMoney(int amount){
    if(amount >= 1000000){
      return "${(amount / 1000000).round()}M";
    }
    if(amount >= 1000){
      return "${(amount / 1000).round()}K";
    }

    return "$amount";
  }
  static String formatCurrency(double value) {
    final formatCurrency = NumberFormat.currency(symbol: "", decimalDigits: 2, locale: 'en_US');
    return formatCurrency.format(value);
  }


  static String mapCurrencyToSymbol(String currency){
    switch(currency.toLowerCase()){
      case "eur":
        return "€";
      case "cad":
        return "\$";
      default:
        return currency;
    }

  }

  static Future<String?> saveFile(String dir, String fileName, File saveFile) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$dir/$fileName';
      // final file = File(filePath);
      // await file.parent.create(recursive: true);
      await saveFile.copy(filePath);
      // await file.writeAsString(saveFile.readAsStringSync());
      print('File saved: $filePath');
      print('File saved: ${saveFile.path}');
      return filePath;
    } catch (e) {
      print('Error saving file: $e');
      return null;
    }
  }
}