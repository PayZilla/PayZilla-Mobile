import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pay_zilla/core/core.dart';

Future<void> main() async {
  await AppSetups.runSetups(environment: Flavor.production).whenComplete(
    () => runApp(MyApp()),
  );
}
