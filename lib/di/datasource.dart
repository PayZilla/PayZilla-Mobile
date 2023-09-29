// data sources

import 'package:get_it/get_it.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/dashboard/data/datasource/account_datasource.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

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
    )
    ..registerFactory<IBillRemoteDataSource>(
      () => BillRemoteDataSource(
        getIt(),
      ),
    )
    ..registerFactory<ICardsRemoteDataSource>(
      () => CardsRemoteDataSource(
        getIt(),
      ),
    )
    ..registerFactory<IAccountRemoteDataSource>(
      () => AccountRemoteDataSource(
        getIt(),
      ),
    )
    ..registerFactory<ITransferRemoteDataSource>(
      () => TransferRemoteDataSource(
        getIt(),
      ),
    );
}
