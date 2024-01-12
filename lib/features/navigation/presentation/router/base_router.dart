import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_zilla/features/analytics/analytics.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/splash_screen/splash_screen.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';

final _savedArgs = {};
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

///use the args registry for situations where multiple nested routes have different argument requirements
T? argsRegistry<T>(String key, Object? args) {
  if (args is T) {
    _savedArgs[key] = args;
  }
  return _savedArgs[key] as T;
}

GoRouter getBaseRouter() {
  return GoRouter(
    initialLocation: AppRoutes.root,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: kDebugMode,
    routes: [
      GoRoute(
        path: AppRoutes.root,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      onboardingRouter(),
      authRouter(),
      pinRouter(),
      countryRouter(),
      GoRoute(
        path: '/biometric',
        builder: (context, state) {
          return const BiometricScreen();
        },
      ),
      GoRoute(
        path: '/transfer-success',
        builder: (context, state) => TransactionSuccessScreen(
          args: argsRegistry<TransactionSuccessArgs>(
            'transfer-success',
            state.extra,
          )!,
        ),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          AppNavTab? tab;
          bool? hideNav;
          if (state.fullPath != null) {
            if (state.fullPath!.split('/')[1] == 'tab') {
              final tabName = state.fullPath!.split('/')[2];
              tab = AppNavTabUtil.fromString(tabName);
              try {
                hideNav = state.fullPath!.split('/')[3].isNotEmpty;
              } catch (e) {
                hideNav = false;
              }
              if (tab == null) {
                throw PageNotFoundException(state.fullPath!);
              }
            }
          }

          return Scaffold(
            body: Column(
              children: [
                Expanded(child: child),
                if (tab != null)
                  BottomNavigationContainer(
                    selectedTab: tab,
                    hideNav: hideNav ?? false,
                  ),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) {
              return const DashboardScreen();
            },
            routes: dashboardRouter,
          ),
          GoRoute(
            path: AppRoutes.myCard,
            builder: (context, state) {
              return const MyCardScreen();
            },
            routes: myCardRouter,
          ),
          GoRoute(
            path: AppRoutes.activity,
            builder: (context, state) {
              return const AnalyticsScreen();
            },
          ),
          GoRoute(
            path: AppRoutes.profile,
            builder: (context, state) {
              return const ProfileScreen();
            },
            routes: profileRouter,
          ),
        ],
      ),
    ],
  );
}
