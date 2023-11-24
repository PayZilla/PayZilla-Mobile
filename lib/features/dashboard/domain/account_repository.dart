import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/dashboard/data/datasource/account_datasource.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

abstract class AccountRepository {
  Future<Either<ApiFailure, List<WalletsModel>>> getWallets();
  Future<Either<ApiFailure, List<ContactsModel>>> getContacts(
    List<String> contacts,
  );
  Future<Either<ApiFailure, AccountDetailsModel>> getAccounts();
}

class AccountRepositoryImpl extends AccountRepository {
  AccountRepositoryImpl({
    required this.remoteDataSource,
  });

  final IAccountRemoteDataSource remoteDataSource;

  @override
  Future<Either<ApiFailure, List<WalletsModel>>> getWallets() async {
    return remoteDataSource.getWallets();
  }

  @override
  Future<Either<ApiFailure, List<ContactsModel>>> getContacts(
    List<String> contacts,
  ) async {
    return remoteDataSource.getContacts(contacts);
  }

  @override
  Future<Either<ApiFailure, AccountDetailsModel>> getAccounts() async {
    return remoteDataSource.getAccounts();
  }
}
