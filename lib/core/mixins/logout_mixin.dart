import 'package:flutter/material.dart';
import 'package:pay_zilla/di/dependency_injection_container.dart';
import 'package:pay_zilla/features/auth/auth.dart';

mixin LogoutMixin {
  @protected
  void logout() {
    // sl<AuthProvider>().logout(context);
  }

  @protected
  void sessionTimeout({
    String reason =
        'Your session was timed-out due to inactivity on this page.',
    required BuildContext context,
  }) {
    sl<AuthProvider>().sessionLogout(context);
  }

  @protected
  void sessionLogout() {
    //clear session and reroute user to onboarding welcome screen
    // sl<AuthProvider>().logout(context);
  }
}
