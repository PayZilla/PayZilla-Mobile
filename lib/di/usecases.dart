import 'package:get_it/get_it.dart';
import 'package:pay_zilla/features/auth/usecase/auth_usecase.dart';
import 'package:pay_zilla/features/auth/usecase/user_usecase.dart';
import 'package:pay_zilla/features/dashboard/usecase/acount_usecases.dart';
import 'package:pay_zilla/features/dashboard/usecase/bills_usecase.dart';
import 'package:pay_zilla/features/dashboard/usecase/cards_usecase.dart';
import 'package:pay_zilla/features/notifications/usecase/notification_usecase.dart';
import 'package:pay_zilla/features/profile/usecase/profile_usecase.dart';
import 'package:pay_zilla/features/transaction/usecase/transaction_usecase.dart';
import 'package:pay_zilla/features/transaction/usecase/transfer_usecase.dart';

void registerUseCases(GetIt getIt) {
  getIt
    ..registerFactory(
      () => LogInUseCase(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => GetUserUseCase(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => GetUserKycUseCase(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => SignUpUseCase(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => EmailVerificationUseCase(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => TokenVerificationUseCase(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => FetchReasonsUseCase(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => ForgotPasswordResetUseCase(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => ForgotPasswordUseCase(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => InitializeBvnUseCase(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => SubmitBvnUseCase(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => PinSetupUseCase(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => PurposeUseCase(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => UpdateBvnUseCase(
        authRepository: getIt(),
      ),
    );
  accountUseCase(getIt);
  billsUseCase(getIt);
  cardsUseCases(getIt);
  notificationUseCase(getIt);
  profileUseCase(getIt);
  transactionUseCase(getIt);
  transferUseCase(getIt);
}

void accountUseCase(GetIt getIt) {
  getIt
    ..registerFactory(() => GetWalletsUseCase(accountRepository: getIt()))
    ..registerFactory(() => GetContactsUseCase(accountRepository: getIt()))
    ..registerFactory(() => GetAccountsUseCase(accountRepository: getIt()));
}

void billsUseCase(GetIt getIt) {
  getIt
    ..registerFactory(() => GetCatsUseCase(billsRepository: getIt()))
    ..registerFactory(() => GetCatsIDUseCase(billsRepository: getIt()))
    ..registerFactory(() => GetServiceIdUseCase(billsRepository: getIt()))
    ..registerFactory(() => PurchaseUseCase(billsRepository: getIt()))
    ..registerFactory(() => VerifyUseCase(billsRepository: getIt()))
    ..registerFactory(() => PayBillUseCase(billsRepository: getIt()));
}

void cardsUseCases(GetIt getIt) {
  getIt
    ..registerFactory(() => GetCardsUseCase(cardsRepository: getIt()))
    ..registerFactory(() => InitCardsUseCase(cardsRepository: getIt()))
    ..registerFactory(() => FinalizeCardsUseCase(cardsRepository: getIt()))
    ..registerFactory(() => DeleteCardsUseCase(cardsRepository: getIt()))
    ..registerFactory(() => ChargeCardsUseCase(cardsRepository: getIt()));
}

void notificationUseCase(GetIt getIt) {
  getIt
    ..registerFactory(
      () => GetNotificationUseCase(notificationRepository: getIt()),
    )
    ..registerFactory(
      () => GetNotificationsUseCase(notificationRepository: getIt()),
    )
    ..registerFactory(
      () => MarkNotificationUseCase(notificationRepository: getIt()),
    )
    ..registerFactory(
      () => MarkNotificationsUseCase(notificationRepository: getIt()),
    );
}

void profileUseCase(GetIt getIt) {
  getIt
    ..registerFactory(() => UploadImageUseCase(profileRepository: getIt()))
    ..registerFactory(() => UpdateProfileUseCase(profileRepository: getIt()))
    ..registerFactory(() => GetFaqsUseCase(profileRepository: getIt()));
}

void transactionUseCase(GetIt getIt) {
  getIt
    ..registerFactory(
      () => TransactionUseCase(transactionHistoryRepository: getIt()),
    )
    ..registerFactory(
      () => TransactionOverviewUseCase(transactionHistoryRepository: getIt()),
    )
    ..registerFactory(
      () => GetTransactionUseCase(transactionHistoryRepository: getIt()),
    );
}

void transferUseCase(GetIt getIt) {
  getIt
    ..registerFactory(() => TransferUseCase(transferRepository: getIt()))
    ..registerFactory(() => ValidateBankUseCase(transferRepository: getIt()))
    ..registerFactory(
      () => TransferWalletBankUseCase(transferRepository: getIt()),
    );
}
