import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  late final SharedPreferences prefs;

  Future<SharedPreferences> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  bool? getBool(
    String key,
  ) =>
      prefs.getBool(key);
  Future<bool> setBool(String key, bool value) => prefs.setBool(key, value);
}
