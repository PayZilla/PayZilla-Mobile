import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

Future<void> main() async {
  await AppSetups.runSetups(enableLogging: true).whenComplete(
    () {
      Log().debug('The onboarding view model providers are registered');

      runZonedGuarded(() async => runApp(MyApp()), (error, trace) {
        if (kReleaseMode) {
          FirebaseCrashlytics.instance.recordError(error, trace);
        }
      });
    },
  );
}
