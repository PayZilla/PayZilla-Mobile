import 'package:flutter/material.dart';
import 'package:pay_zilla/di/dependency_injection_container.dart';
import 'package:pay_zilla/features/auth/auth.dart';

mixin LogoutMixin {
  late BuildContext context;
  @protected
  void logout() {}

  @protected
  void sessionTimeout({
    String reason =
        'Your session was timed-out due to inactivity on this page.',
  }) {
    sl<AuthProvider>().sessionTimeout(reason, context);
  }

  @protected
  void sessionLogout() {
    //clear session and reroute user to onboarding welcome screen
    sl<AuthProvider>().logout(context);
  }
}
