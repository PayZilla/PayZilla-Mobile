import 'package:go_router/go_router.dart';
import 'package:pay_zilla/features/onboarding/onboarding.dart';

GoRoute onboardingRouter() {
  return GoRoute(
    path: '/onboarding',
    builder: (context, state) {
      return const OnboardingScreen();
    },
    routes: [],
  );
}
