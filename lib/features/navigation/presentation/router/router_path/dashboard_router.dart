import 'package:go_router/go_router.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
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
    path: 'transfer-bank',
    builder: (context, state) {
      return const BankTransferScreen();
    },
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
    routes: [
      GoRoute(
        path: 'scan-qr-screen',
        builder: (context, state) {
          return ScanQrScreen(
            args: argsRegistry<ScanQrScreenArgs>(
              'scan-qr-screen',
              state.extra,
            ),
          );
        },
      ),
    ],
  ),
  GoRoute(
    path: 'qr-show-scanner',
    builder: (context, state) {
      return OtherUserQrScreen(
        args: argsRegistry<OtherUserQrScreenArgs>(
          'qr-show-scanner',
          state.extra,
        )!,
      );
    },
  ),
  GoRoute(
    path: 'funding-account-details',
    builder: (context, state) => const FundingAccountDetails(),
  ),
  GoRoute(
    path: 'top-up-amount',
    builder: (context, state) => TopUpWidget(
      args: argsRegistry<TopUpArgs>(
        'top-up-amount',
        state.extra,
      )!,
    ),
  ),
  GoRoute(
    path: 'bill-payment-verification',
    builder: (context, state) => BillPaymentVerificationScreen(
      args: argsRegistry<BillPaymentVerificationScreenArgs>(
        'bill-payment-verification',
        state.extra,
      )!,
    ),
  )
];
