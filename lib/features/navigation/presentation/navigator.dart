import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigator {
  AppNavigator._(this.context);

  factory AppNavigator.of(BuildContext context) {
    return AppNavigator._(context);
  }

  BuildContext context;

  void push(String location, {Object? args}) {
    context.go(location, extra: args);
  }

  ///use to go back to a previous route
  void pop() {
    GoRouter.of(context).pop();
  }

  /// use to pop an open dialog modal
  void popDialog([dynamic data]) {
    GoRouter.of(context).pop(data);
  }
}
