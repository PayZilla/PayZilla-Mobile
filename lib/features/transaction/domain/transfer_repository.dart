import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

abstract class TransferRepository {
  Future<Either<ApiFailure, List<BanksModel>>> getBanks();
  Future<Either<ApiFailure, WalletOrBankModel>> validateBanksOrWallet(
    ValidateBankOrWalletDto params,
  );
  Future<Either<ApiFailure, String>> transferBanksOrWallet(
    ValidateBankOrWalletDto params,
  );
}

class TransferRepositoryImpl extends TransferRepository {
  TransferRepositoryImpl({
    required this.remoteDataSource,
  });

  final ITransferRemoteDataSource remoteDataSource;

  @override
  Future<Either<ApiFailure, List<BanksModel>>> getBanks() async {
    return remoteDataSource.getBanks();
  }

  @override
  Future<Either<ApiFailure, WalletOrBankModel>> validateBanksOrWallet(
    ValidateBankOrWalletDto params,
  ) async {
    return remoteDataSource.validateBanksOrWallet(params);
  }

  @override
  Future<Either<ApiFailure, String>> transferBanksOrWallet(
    ValidateBankOrWalletDto params,
  ) async {
    return remoteDataSource.transferBanksOrWallet(params);
  }
}
