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
              return VerifyEmailOtpRecovery(
                args: argsRegistry<VerifyEmailOtpRecoveryArgs>(
                  'verify',
                  state.extra,
                )!,
              );
            },
            routes: [
              GoRoute(
                path: 'new-password',
                builder: (context, state) {
                  return const NewPasswordScreen();
                },
              )
            ],
          )
        ],
      ),
      GoRoute(
        path: 'sign-up',
        builder: (context, state) {
          return const SignUpScreen();
        },
      ),
    ],
  );
}
