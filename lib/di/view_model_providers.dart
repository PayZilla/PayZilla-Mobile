// View models
import 'package:get_it/get_it.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/onboarding/onboarding.dart';
import 'package:pay_zilla/features/profile/profile.dart';

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
      ProfileProvider.new,
    );
}
