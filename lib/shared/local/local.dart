import 'package:quran/shared/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static late SharedPreferences prefs;

  static Future<SharedPreferences> init() async {
    return sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<SharedPreferences> initPrefs() async {
    return prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setInteger(
      {required String key, required int value}) async {
    return await sharedPreferences.setInt(key, value);
  }

  static Future saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('arabicFontSize', arabicFontSize.toInt());
    await prefs.setInt('mushafFontSize', mushafFontSize.toInt());
  }

  static getSettings() {
    try {
      prefs.getInt('arabicFontSize');
      prefs.getInt('mushafFontSize');
    } catch (_) {
      arabicFontSize = 28;
      mushafFontSize = 40;
    }
  }

  static int getInteger({required String key}) {
    return sharedPreferences.getInt(key)!;
  }
}
