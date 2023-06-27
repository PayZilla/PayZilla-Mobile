import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pay_zilla/core/core.dart';

class SecureLocalCache implements ILocalCache {
  SecureLocalCache(this._secureStorage);
  final FlutterSecureStorage _secureStorage;

  @override
  Future<void> flush() async {
    await _secureStorage.deleteAll();
  }

  @override
  Future<T?> get<T>(String key) async {
    try {
      final value = await _secureStorage.read(key: key);
      return value as T?;
    } on PlatformException catch (_) {
      await _secureStorage.deleteAll();
      return null;
    }
  }

  @override
  Future<bool> has(String key) async => _secureStorage.containsKey(key: key);

  @override
  Future<void> put(String key, dynamic value) async {
    try {
      await _secureStorage.write(key: key, value: value as String);
    } catch (_) {
      throw CachePutException();
    }
  }

  @override
  Future<void> remove(String key) async {
    await _secureStorage.delete(key: key);
  }
}
