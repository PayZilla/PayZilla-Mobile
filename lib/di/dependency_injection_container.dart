import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/di/datasource.dart';
import 'package:pay_zilla/di/repositories.dart';
import 'package:pay_zilla/di/usecases.dart';
import 'package:pay_zilla/di/view_model_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator(
  Flavor flavor, {
  bool enableLogging = true,
}) async {
  // register data sources
  registerDataSources(sl);

  // register repositories
  registerRepositories(sl);

  // register view models

  registerViewModelProviders(sl);

  //storage
  _registerStorage();

  // register others
  await _registerOthers(flavor, enableLogging);

// register use cases
  registerUseCases(sl);
}

// Any other class
Future<void> _registerOthers(Flavor flavor, bool enableLogging) async {
  final sessionToken = const Uuid().v4();

  const secureStorage = FlutterSecureStorage();
  final localAuth = LocalAuthentication();
  final connectivity = Connectivity();
  final localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final sharePreference = await SharedPreferences.getInstance();

  sl
    ..registerFactory<SharedPreferences>(() => sharePreference)
    ..registerSingleton(AppEnvManager(flavor))
    ..registerSingleton(secureStorage)
    ..registerSingleton(localAuth)
    ..registerSingleton(connectivity)
    ..registerSingleton(localNotificationsPlugin)
    ..registerSingleton(NotificationManager(sl()))
    ..registerSingleton(
      HttpManager(
        cache: sl<SecureLocalCache>(),
        baseUrl: AppConfig.baseUrl,
        enableLogging: enableLogging,
      ),
    )
    ..registerSingleton(NetworkManager(sl()))
    ..registerSingleton(CloudImageManager());
}

void _registerStorage() {
  sl
    ..registerFactory<SharedPrefLocalCache>(() => SharedPrefLocalCache(sl()))
    ..registerFactory<SecureLocalCache>(() => SecureLocalCache(sl()));
}
