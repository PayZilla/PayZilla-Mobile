import 'package:go_router/go_router.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/presentation/router/base_router.dart';

GoRoute authRouter() {
  return GoRoute(
    path: '/auth',
    builder: (context, state) {
      return const SignIn();
    },
    routes: [
      GoRoute(
        path: 'recovery',
        builder: (context, state) {
          return const EmailRecovery();
        },
        routes: [
          GoRoute(
            path: 'verify',
            builder: (context, state) {
              return GenericTokenVerification(
                args: argsRegistry<GenericTokenVerificationArgs>(
                  'verify',
                  state.extra,
                )!,
              );
            },
            routes: [
              GoRoute(
                path: 'new-password',
                builder: (context, state) {
                  return NewPasswordScreen(
                    args: argsRegistry<NewPasswordArgs>(
                      'new-password',
                      state.extra,
                    )!,
                  );
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: 'sign-up',
        builder: (context, state) {
          return const SignUpScreen();
        },
      ),
      GoRoute(
        path: 'country',
        builder: (context, state) {
          return const CountryScreen();
        },
      ),
    ],
  );
}
