import 'package:go_router/go_router.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/presentation/router/base_router.dart';

GoRoute pinRouter() {
  return GoRoute(
    path: '/pin',
    builder: (context, state) {
      return GenericTokenVerification(
        args: argsRegistry<GenericTokenVerificationArgs>(
          'pin',
          state.extra,
        )!,
      );
    },
  );
}

GoRoute countryRouter() {
  return GoRoute(
    path: '/country',
    builder: (context, state) {
      return const CountryScreen();
    },
    routes: [
      GoRoute(
        path: 'bvn-verification',
        builder: (context, state) => const BvnScreen(),
        routes: [
          GoRoute(
            path: 'reasons',
            builder: (context, state) {
              return const ReasonsScreen();
            },
            routes: [
              GoRoute(
                path: 'pin',
                builder: (context, state) {
                  return const PinSetupScreen();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
