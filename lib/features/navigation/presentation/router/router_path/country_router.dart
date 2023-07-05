import 'package:go_router/go_router.dart';
import 'package:pay_zilla/features/auth/auth.dart';

GoRoute countryRouter() {
  return GoRoute(
    path: '/country',
    builder: (context, state) {
      return const CountryScreen();
    },
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
            routes: [
              GoRoute(
                path: 'bvn-verification',
                builder: (context, state) => const BvnScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
