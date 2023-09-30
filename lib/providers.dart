import 'package:get_it/get_it.dart';
import 'package:pay_zilla/features/analytics/analytics.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/notifications/notifications.dart';
import 'package:pay_zilla/features/onboarding/onboarding.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider<OnboardingProvider>(
    create: (_) => GetIt.I<OnboardingProvider>(),
  ),
  ChangeNotifierProvider<AuthProvider>(
    create: (_) => GetIt.I<AuthProvider>(),
  ),
  ChangeNotifierProvider<MyCardsProvider>(
    create: (_) => GetIt.I<MyCardsProvider>(),
  ),
  ChangeNotifierProvider<ProfileProvider>(
    create: (_) => GetIt.I<ProfileProvider>(),
  ),
  ChangeNotifierProvider<NotificationProvider>(
    create: (_) => GetIt.I<NotificationProvider>(),
  ),
  ChangeNotifierProvider<AnalyticProvider>(
    create: (_) => GetIt.I<AnalyticProvider>(),
  ),
  ChangeNotifierProvider<DashboardProvider>(
    create: (_) => GetIt.I<DashboardProvider>(),
  ),
  ChangeNotifierProvider<TransactionProvider>(
    create: (_) => GetIt.I<TransactionProvider>(),
  ),
  ChangeNotifierProvider<TransactionHistoryProvider>(
    create: (_) => GetIt.I<TransactionHistoryProvider>(),
  ),
];
