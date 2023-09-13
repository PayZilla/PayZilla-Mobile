import 'dart:async';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';

abstract class IAuthLocalDataSource {
  FutureOr<bool?> get showVerificationBanner;
  FutureOr<bool?> get getBiometricMode;

  FutureOr<String> getUserEmail();
  FutureOr<String> getUserPassword(); // for biometric auth
  FutureOr<dynamic> getAuthUserPref();
  FutureOr<bool> getUserBiometric();
  void hideVerificationBanner();
  void saveUserEmail(String email);

  void saveUserPassword(String password);
  void saveToken(String token);
  void saveBiometricMode({required bool value});
  void saveAuthUserPref(User pref);
  void flushLocalStorage();
  void saveBiometricStatus({required bool status});
}

class AuthLocalDataSource implements IAuthLocalDataSource {
  AuthLocalDataSource(ILocalCache localCache, ILocalCache secureLocalCache)
      : _localCache = localCache,
        _secureLocalCache = secureLocalCache;
  final ILocalCache _localCache;
  final ILocalCache _secureLocalCache;

  @override
  FutureOr<String> getUserEmail() async {
    final email = await _secureLocalCache.get<String>(CacheKeys.email);
    if (email != null) {
      return email;
    }
    return '';
  }

  @override
  FutureOr<String> getUserPassword() async {
    final password = await _secureLocalCache.get<String>(CacheKeys.password);
    if (password != null) {
      return password;
    }
    return '';
  }

  @override
  FutureOr<bool> getUserBiometric() async {
    final biometric = await _secureLocalCache.get<bool>(CacheKeys.biometric);

    if (biometric != null) {
      return biometric;
    }

    return false;
  }

  @override
  void saveToken(String token) {
    unawaited(_secureLocalCache.put(CacheKeys.token, token));
  }

  @override
  void saveUserEmail(String email) {
    unawaited(_secureLocalCache.put(CacheKeys.email, email));
  }

  @override
  void saveUserPassword(String password) {
    unawaited(_secureLocalCache.put(CacheKeys.password, password));
  }

  @override
  void flushLocalStorage() {
    unawaited(_localCache.flush());
    unawaited(_secureLocalCache.flush());
  }

  @override
  void saveBiometricStatus({required bool status}) {
    unawaited(_secureLocalCache.put(CacheKeys.biometric, status));
  }

  @override
  void saveBiometricMode({required bool value}) {
    unawaited(
      _localCache.put(
        CacheKeys.biometricMode,
        value,
      ),
    );
  }

  @override
  FutureOr<bool?> get getBiometricMode async {
    return await _localCache.get<bool>(CacheKeys.biometricMode);
  }

  @override
  FutureOr<bool?> get showVerificationBanner async {
    return await _localCache.get<bool>(CacheKeys.showVerificationBanner);
  }

  @override
  void hideVerificationBanner() {
    unawaited(
      _localCache.put(
        CacheKeys.showVerificationBanner,
        false,
      ),
    );
  }

  @override
  FutureOr getAuthUserPref() async {
    dynamic defaultPref;
    final pref = await _localCache.get<String>(CacheKeys.user);
    if (pref != null) {
      return pref;
    }
    return defaultPref;
  }

  @override
  void saveAuthUserPref(User pref) {
    unawaited(_localCache.put(CacheKeys.user, pref.toJson()));
  }
}
