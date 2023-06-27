import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';

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
    initialLocation: PZillaRoutes.splash,
    navigatorBuilder: (context, state, child) {
      PZillaTab? tab;
      bool? hideNav;

      if (state.location.split('/')[1] == 'tab') {
        final tabName = state.location.split('/')[2];
        tab = PZillaTabUtil.fromString(tabName);
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
        path: '/tab/:tab_name',
        builder: (context, state) {
          final tabName = state.params['tab_name'];
          final tab = PZillaTabUtil.fromString(tabName);

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
        ],
      )
    ],
  );
}
