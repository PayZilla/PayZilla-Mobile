import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:pay_zilla/di/dependency_injection_container.dart';

class AnalyticsEvent {
  static const String userLogin = 'user_login';
}

class AnalyticsManager {
  AnalyticsManager({
    required this.firebaseAnalytics,
  });

  final FirebaseAnalytics firebaseAnalytics;

  static AnalyticsManager get instance {
    return sl<AnalyticsManager>();
  }

  void logEvent(String name, {Map<String, dynamic>? parameters}) {
    if (kReleaseMode) {
      firebaseAnalytics.logEvent(name: name, parameters: parameters);
    }
  }

  void logAdjustOtherEvent(
    String eventToken,
    String eventIdKey,
    String eventValue,
  ) {
    if (kReleaseMode) {}
  }

  void logAdjustUserDataEvent(
    String eventToken,
    String kycRefIdKey,
    String kycRefIdValue,
    int conversionValue,
  ) {
    if (kReleaseMode) {}
  }

  void trackLogin(String loginMethod) {
    logEvent(
      AnalyticsEvent.userLogin,
      parameters: {
        'login_method': loginMethod,
      },
    );
  }
}
