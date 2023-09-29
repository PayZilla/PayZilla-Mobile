import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

class TransferRepository extends Repository {
  TransferRepository({
    required this.remoteDataSource,
  });

  final ITransferRemoteDataSource remoteDataSource;

  Future<Either<Failure, List<BanksModel>>> getBanks() async {
    return runGuard(() async {
      final response = await remoteDataSource.getBanks();

      return response;
    });
  }

  Future<Either<Failure, WalletOrBankModel>> validateBanksOrWallet(
    ValidateBankOrWalletDto params,
  ) async {
    return runGuard(() async {
      final response = await remoteDataSource.validateBanksOrWallet(params);

      return response;
    });
  }

  Future<Either<Failure, String>> transferBanksOrWallet(
    ValidateBankOrWalletDto params,
  ) async {
    return runGuard(() async {
      final response = await remoteDataSource.transferBanksOrWallet(params);

      return response;
    });
  }
}
