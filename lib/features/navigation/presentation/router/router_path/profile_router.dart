import 'package:go_router/go_router.dart';
import 'package:pay_zilla/features/profile/profile.dart';

final profileRouter = [
  GoRoute(
    path: 'referral',
    builder: (context, state) {
      return const ReferralScreen();
    },
  ),
  GoRoute(
    path: 'account-info',
    builder: (context, state) {
      return const AccountInfoScreen();
    },
    routes: [
      GoRoute(
        path: 'edit',
        builder: (context, state) {
          return const EditAccountInfoScreen();
        },
      )
    ],
  ),
  GoRoute(
    path: 'contact',
    builder: (context, state) {
      return const ContactScreen();
    },
  ),
  GoRoute(
    path: 'general',
    builder: (context, state) {
      return const GeneralSettingsScreen();
    },
  ),
  GoRoute(
    path: 'faq',
    builder: (context, state) {
      return const FaqScreen();
    },
  ),
];
