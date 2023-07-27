import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/qr/qr.dart';
import 'package:pay_zilla/features/splash_screen/splash_screen.dart';

final _savedArgs = {};

///use the args registry for situations where multiple nested routes have different argument requirements
T? argsRegistry<T>(String key, Object? args) {
  if (args is T) {
    _savedArgs[key] = args;
  }
  return _savedArgs[key] as T;
}

GoRouter getBaseRouter() {
  return GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    initialLocation: AppRoutes.splash,
    navigatorBuilder: (context, state, child) {
      AppNavTab? tab;
      bool? hideNav;

      if (state.location.split('/')[1] == 'tab') {
        final tabName = state.location.split('/')[2];
        tab = AppNavTabUtil.fromString(tabName);
        try {
          //Note (Dev) => this is for cases where you have nested route inside of a tab and you don't want to show the bottom nav (design spec)
          hideNav = state.location.split('/')[3].isNotEmpty;
        } catch (e) {
          hideNav = false;
        }

        if (tab == null) {
          throw PageNotFoundException(state.location);
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
        path: '/splash',
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      onboardingRouter(),
      authRouter(),
      countryRouter(),
      GoRoute(
        path: '/biometric',
        builder: (context, state) {
          return const BiometricScreen();
        },
      ),
      //Note (Dev)=> create sub routes for nav tabs inside this routes list
      GoRoute(
        path: '/tab/:tab_name',
        builder: (context, state) {
          final tabName = state.params['tab_name'];
          final tab = AppNavTabUtil.fromString(tabName);

          if (tab == null) {
            throw PageNotFoundException(state.location);
          }

          tabScreens.sort((a, b) => a.tab.index.compareTo(b.tab.index));

          return IndexedStack(
            key: const ValueKey('tab_indexed_stack'),
            index: tab.index,
            children: tabScreens.map((e) => e.body).toList(),
          );
        },
        routes: [
          //Note (Dev)=> create sub routes for nav tabs
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
          myCardRouter(),
          GoRoute(
            path: 'edit-card',
            builder: (context, state) => EditCardScreen(
              args: argsRegistry<EditCardScreenArgs>(
                'edit-card',
                state.extra,
              )!,
            ),
          ),
          ...profileRouter
        ],
      )
    ],
  );
}
