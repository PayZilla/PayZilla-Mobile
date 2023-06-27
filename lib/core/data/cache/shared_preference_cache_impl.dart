import 'dart:async';

import 'package:pay_zilla/core/data/cache/cache.dart';
import 'package:pay_zilla/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefLocalCache implements ILocalCache {
  SharedPrefLocalCache(this._preferences);
  final SharedPreferences _preferences;

  @override
  Future<void> flush() async {
    await _preferences.clear();
  }

  @override
  Future<T?> get<T>(String key) async {
    final value = _preferences.get(key);
    return value as T?;
  }

  @override
  bool has(String key) => _preferences.containsKey(key);

  @override
  Future<void> put(String key, dynamic value) async {
    switch (value.runtimeType) {
      case String:
        await _preferences.setString(key, value as String);
        break;
      case int:
        await _preferences.setInt(key, value as int);
        break;
      case double:
        await _preferences.setDouble(key, value as double);
        break;
      case bool:
        await _preferences.setBool(key, value as bool);
        break;
      default:
        throw CachePutException();
    }
  }

  @override
  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }
}
