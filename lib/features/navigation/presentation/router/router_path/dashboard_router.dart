import 'package:go_router/go_router.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/notifications/notifications.dart';
import 'package:pay_zilla/features/qr/qr.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

final dashboardRouter = [
  GoRoute(
    path: 'notifications',
    builder: (context, state) {
      return const NotificationScreen();
    },
  ),
  GoRoute(
    path: 'transfer',
    builder: (context, state) {
      return const TransferScreen();
    },
    routes: [
      GoRoute(
        path: 'send-money',
        builder: (context, state) {
          return SendMoneyScreen(
            args: argsRegistry<SendMoneyScreenArgs>(
              'send-money',
              state.extra,
            )!,
          );
        },
      ),
    ],
  ),
  GoRoute(
    path: 'all-transactions',
    builder: (context, state) {
      return const AllTransactionsScreen();
    },
  ),
  GoRoute(
    path: 'qr-scanner',
    builder: (context, state) {
      return QRScanScreen(
        args: argsRegistry<QRScreenArgs>(
          'qr-scanner',
          state.extra,
        )!,
      );
    },
  ),
  GoRoute(
    path: 'qr-show-scanner',
    builder: (context, state) {
      return QrShowScreen(
        args: argsRegistry<QrShowScreenArgs>(
          'qr-show-scanner',
          state.extra,
        )!,
      );
    },
  ),
];
