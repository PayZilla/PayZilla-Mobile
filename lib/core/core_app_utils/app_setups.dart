import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/di/dependency_injection_container.dart' as locator;
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class AppSetups {
  static Future<void> runSetups({
    Flavor environment = Flavor.development,
    bool enableLogging = false,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (Platform.isAndroid) {
        await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
      }
    });

    /// load env variables
    await dotenv.load();

    // init logger
    Log.init();
    // set the environment
    AppConfig.setEnvironment(environment);
    // init service locator => 1
    await locator.initServiceLocator(environment, enableLogging: enableLogging);
  }
}
