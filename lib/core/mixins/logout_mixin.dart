import 'package:flutter/material.dart';

mixin LogoutMixin {
  @protected
  void logout() {}

  @protected
  void sessionTimeout({
    String reason =
        'Your session was timed-out due to inactivity on this page.',
  }) {}

  @protected
  void sessionLogout() {
    //clear session and reroute user to onboarding welcome screen
  }
}
