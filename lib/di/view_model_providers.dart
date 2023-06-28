// View models
import 'package:get_it/get_it.dart';
import 'package:pay_zilla/features/onboarding/onboarding.dart';

void registerViewModelProviders(GetIt getIt) {
  getIt.registerFactory(OnboardingProvider.new);
}
