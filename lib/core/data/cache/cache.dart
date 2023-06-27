import 'dart:async';

abstract class ILocalCache {
  FutureOr<bool> has(String key);
  FutureOr<T?> get<T>(String key);
  Future<void> put(String key, dynamic value);

  Future<void> remove(String key);
  Future<void> flush();
}
