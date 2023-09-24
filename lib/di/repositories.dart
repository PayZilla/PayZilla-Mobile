// Repositories
import 'package:get_it/get_it.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/qr/qr.dart';

void registerRepositories(GetIt getIt) {
  getIt
    ..registerFactory(
      () => AuthRepository(
        localAuthentication: getIt(),
        localDataSource: getIt(),
        remoteDataSource: getIt(),
      ),
    )
    ..registerFactory(
      () => ProfileRepository(
        remoteDataSource: getIt(),
      ),
    )
    ..registerFactory(
      () => QrRepository(
        remoteDataSource: getIt(),
      ),
    );
}
