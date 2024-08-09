import 'dart:io';
import 'dart:typed_data';

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
      final filePath = '${directory.path}/$dir';
      Directory targetDir = Directory(filePath);
      if(!targetDir.existsSync()){
        await targetDir.create(recursive: true);
      }
      String newFilePath = '${targetDir.path}/$fileName';
      File newFile = await saveFile.copy(newFilePath);
      // await file.writeAsString(saveFile.readAsStringSync());
      // print('File saved: ${newFile.readAsBytesSync()}');
      print('File saved: $newFilePath');
      return newFilePath;
    } catch (e) {
      print('Error saving file: $e');
      return null;
    }
  }

  static Future<String?> replaceImage(Uint8List saveFile, File currentFile) async {
    try {
      await currentFile.writeAsBytes(saveFile);
      return currentFile.path;
    } catch (e) {
      print('Error saving file: $e');
      return null;
    }
  }
}
