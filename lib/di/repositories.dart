// Repositories
import 'package:get_it/get_it.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/notifications/notifications.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

void registerRepositories(GetIt getIt) {
  getIt
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImp(
        localAuthentication: getIt(),
        remoteDataSource: getIt(),
      ),
    )
    ..registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(
        remoteDataSource: getIt(),
      ),
    )
    ..registerFactory<BillRepository>(
      () => BillRepositoryImpl(
        remoteDataSource: getIt(),
      ),
    )
    ..registerFactory<CardsRepository>(
      () => CardsRepositoryImpl(
        remoteDataSource: getIt(),
      ),
    )
    ..registerFactory<AccountRepository>(
      () => AccountRepositoryImpl(
        remoteDataSource: getIt(),
      ),
    )
    ..registerFactory<TransferRepository>(
      () => TransferRepositoryImpl(
        remoteDataSource: getIt(),
      ),
    )
    ..registerFactory<NotificationRepository>(
      () => NotificationRepositoryImpl(getIt()),
    )
    ..registerFactory<TransactionHistoryRepository>(
      () => TransactionHistoryRepositoryImpl(
        remoteDataSource: getIt(),
      ),
    );
}
