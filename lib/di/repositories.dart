// Repositories
import 'package:get_it/get_it.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/notifications/notifications.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

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
      () => BillRepository(
        remoteDataSource: getIt(),
      ),
    )
    ..registerFactory(
      () => CardsRepository(
        remoteDataSource: getIt(),
      ),
    )
    ..registerFactory(
      () => AccountRepository(
        remoteDataSource: getIt(),
      ),
    )
    ..registerFactory(
      () => TransferRepository(
        remoteDataSource: getIt(),
      ),
    )
    ..registerFactory(
      () => NotificationRepository(getIt()),
    );
}
