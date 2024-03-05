// View models
import 'package:get_it/get_it.dart';
import 'package:pay_zilla/features/analytics/analytics.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/notifications/notifications.dart';
import 'package:pay_zilla/features/onboarding/onboarding.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

void registerViewModelProviders(GetIt getIt) {
  getIt
    ..registerFactory(OnboardingProvider.new)
    ..registerFactory(
      () => AuthProvider(
        loginUseCase: getIt(),
        userUserCase: getIt(),
        userUserKycCase: getIt(),
        signUpUseCase: getIt(),
        emailVerificationUseCase: getIt(),
        tokenVerificationUseCase: getIt(),
        fetchReasonsUseCase: getIt(),
        forgotPasswordResetUseCase: getIt(),
        forgotPasswordUseCase: getIt(),
        initializeBvnUseCase: getIt(),
        submitBvnUseCase: getIt(),
        pinSetupUseCase: getIt(),
        purposeUseCase: getIt(),
        updateBvnUseCase: getIt(),
      ),
    )
    ..registerFactory(
      MyCardsProvider.new,
    )
    ..registerFactory(
      () => ProfileProvider(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactory(
      () => NotificationProvider(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactory(
      AnalyticProvider.new,
    )
    ..registerFactory(
      () => DashboardProvider(
        chargeCardsUseCase: getIt(),
        deleteCardsUseCase: getIt(),
        finalizeCardsUseCase: getIt(),
        getAccountsUseCase: getIt(),
        getCardsUseCase: getIt(),
        getCatsIDUseCase: getIt(),
        getCatsUseCase: getIt(),
        getContactsUseCase: getIt(),
        getServiceIdUseCase: getIt(),
        getWalletsUseCase: getIt(),
        initCardsUseCase: getIt(),
        payBillUseCase: getIt(),
        purchaseUseCase: getIt(),
        verifyUseCase: getIt(),
      ),
    )
    ..registerFactory(
      () => TransactionProvider(
        accountTranUseCases: getIt(),
        cardsUseCase: getIt(),
        transferUseCase: getIt(),
        getWalletsUseCase: getIt(),
        chargeCardsUseCase: getIt(),
        deleteCardsUseCase: getIt(),
        finalizeCardsUseCase: getIt(),
        initCardsUseCase: getIt(),
        transferWalletBankUseCase: getIt(),
        validateBankUseCase: getIt(),
      ),
    )
    ..registerFactory(
      () => TransactionHistoryProvider(
        getTransactionUseCase: getIt(),
        getSingleTransactionUseCase: getIt(),
      ),
    );
}
