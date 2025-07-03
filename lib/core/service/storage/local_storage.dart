import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences _prefs;

  init() async {
    await SharedPreferences.getInstance();
  }

  get({required String key}) async {
    return _prefs.get(key);
  }

  set({required String key, required value}) async {
    if (value is String) {
      await _prefs.setString(key, value);
      return;
    }

    throw UnimplementedError();
  }

  remove({required String key}) async {
    await _prefs.remove(key);
  }

  reset() async {
    await _prefs.clear();
  }
}
