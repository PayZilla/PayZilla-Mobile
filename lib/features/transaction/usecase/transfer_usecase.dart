import 'package:dartz/dartz.dart';

import 'package:pay_zilla/core/error/failure.dart';
import 'package:pay_zilla/core/mixins/use_case.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

class TransferUseCase extends UseCase<List<BanksModel>, NoParams> {
  TransferUseCase({
    required this.transferRepository,
  });
  TransferRepository transferRepository;
  @override
  Future<Either<ApiFailure, List<BanksModel>>> call(NoParams params) {
    return transferRepository.getBanks();
  }
}

class ValidateBankUseCase
    extends UseCase<WalletOrBankModel, ValidateBankOrWalletDto> {
  ValidateBankUseCase({
    required this.transferRepository,
  });
  TransferRepository transferRepository;
  @override
  Future<Either<ApiFailure, WalletOrBankModel>> call(
    ValidateBankOrWalletDto params,
  ) {
    return transferRepository.validateBanksOrWallet(params);
  }
}

class TransferWalletBankUseCase
    extends UseCase<String, ValidateBankOrWalletDto> {
  TransferWalletBankUseCase({
    required this.transferRepository,
  });
  TransferRepository transferRepository;
  @override
  Future<Either<ApiFailure, String>> call(ValidateBankOrWalletDto params) {
    return transferRepository.transferBanksOrWallet(params);
  }
}
