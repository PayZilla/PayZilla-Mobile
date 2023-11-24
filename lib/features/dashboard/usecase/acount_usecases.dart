import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/core/mixins/use_case.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

class GetWalletsUseCase implements UseCase<List<WalletsModel>, NoParams> {
  GetWalletsUseCase({required this.accountRepository});
  AccountRepository accountRepository;

  @override
  Future<Either<ApiFailure, List<WalletsModel>>> call(NoParams params) {
    return accountRepository.getWallets();
  }
}

class GetContactsUseCase implements UseCase<List<ContactsModel>, List<String>> {
  GetContactsUseCase({required this.accountRepository});
  AccountRepository accountRepository;

  @override
  Future<Either<ApiFailure, List<ContactsModel>>> call(List<String> params) {
    return accountRepository.getContacts(params);
  }
}

class GetAccountsUseCase implements UseCase<AccountDetailsModel, NoParams> {
  GetAccountsUseCase({required this.accountRepository});
  AccountRepository accountRepository;

  @override
  Future<Either<ApiFailure, AccountDetailsModel>> call(NoParams params) {
    return accountRepository.getAccounts();
  }
}
