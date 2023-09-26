import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/dashboard/data/datasource/account_datasource.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

class AccountRepository extends Repository {
  AccountRepository({
    required this.remoteDataSource,
  });

  final IAccountRemoteDataSource remoteDataSource;

  Future<Either<Failure, List<WalletsModel>>> getWallets() async {
    return runGuard(() async {
      final response = await remoteDataSource.getWallets();

      return response;
    });
  }

  Future<Either<Failure, List<ContactsModel>>> getContacts(
    List<String> contacts,
  ) async {
    return runGuard(() async {
      final response = await remoteDataSource.getContacts(contacts);

      return response;
    });
  }

  Future<Either<Failure, AccountDetailsModel>> getAccounts() async {
    return runGuard(() async {
      final response = await remoteDataSource.getAccounts();

      return response;
    });
  }
}
