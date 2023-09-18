// data sources

import 'package:get_it/get_it.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/profile/profile.dart';

void registerDataSources(GetIt getIt) {
  getIt
    ..registerFactory<IAuthLocalDataSource>(
      () => AuthLocalDataSource(
        getIt<SharedPrefLocalCache>(),
        getIt<SecureLocalCache>(),
      ),
    )
    ..registerFactory<IAuthRemoteDataSource>(
      () => AuthRemoteDataSource(
        getIt(),
      ),
    )
    ..registerFactory<IProfileRemoteDataSource>(
      () => ProfileRemoteDataSource(
        getIt(),
      ),
    );
}
