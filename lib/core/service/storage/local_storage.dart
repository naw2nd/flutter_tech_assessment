import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences _prefs;

  init() async {
    log('[LocalStorage] init() called');
    _prefs = await SharedPreferences.getInstance();
    log('[LocalStorage] SharedPreferences initialized');
  }

  get({required String key}) async {
    log('[LocalStorage] get() called with key: $key');
    final value = _prefs.get(key);
    log('[LocalStorage] get() result for key "$key": $value');
    return value;
  }

  set({required String key, required value}) async {
    log('[LocalStorage] set() called with key: $key, value: $value');
    if (value is String) {
      await _prefs.setString(key, value);
      log('[LocalStorage] setString() success for key: $key');
      return;
    }

    log('[LocalStorage] set() failed: Unimplemented type for key: $key');
    throw UnimplementedError();
  }

  remove({required String key}) async {
    log('[LocalStorage] remove() called with key: $key');
    await _prefs.remove(key);
    log('[LocalStorage] remove() success for key: $key');
  }

  reset() async {
    log('[LocalStorage] reset() called');
    await _prefs.clear();
    log('[LocalStorage] reset() success, all keys cleared');
  }
}
