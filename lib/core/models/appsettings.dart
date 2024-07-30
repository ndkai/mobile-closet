import 'package:shared_preferences/shared_preferences.dart';

class AppSettings{
  final String currency;
  final String location;
  final String language;

  AppSettings({this.currency = "cad", this.location = "en", this.language = "en"});

  static Future<AppSettings> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return AppSettings(
      currency: prefs.getString('currency') ?? "cad",
      location: prefs.getString('location') ?? "en",
      language: prefs.getString('language') ?? "en",
    );
  }

  Future<void> saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currency', currency);
    await prefs.setString('location', location);
    await prefs.setString('language', language);
  }
}