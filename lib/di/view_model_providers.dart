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
      () => AuthProvider(authRepository: getIt()),
    )
    ..registerFactory(
      MyCardsProvider.new,
    )
    ..registerFactory(
      () => ProfileProvider(getIt(), getIt()),
    )
    ..registerFactory(
      NotificationProvider.new,
    )
    ..registerFactory(
      AnalyticProvider.new,
    )
    ..registerFactory(
      DashboardProvider.new,
    )
    ..registerFactory(
      TransactionProvider.new,
    );
}
