import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

String jsonPretty(Object obj) {
  const encoder = JsonEncoder.withIndent('  ');
  final prettyprint = encoder.convert(obj);
  return prettyprint;
}

class Log {
  factory Log() => _instance!;

  Log._(this.production);

  static void init({bool production = false}) => _instance = Log._(production);

  static late Log? _instance;

  final bool production;

  /// json formatted log
  void jsonLog(String message, [Object? json]) {
    final jsonVal = '\x1B[37m${_stringifyMessage(jsonEncode(json))}\x1B';
    log(message, error: jsonVal);
  }

  void debug(String tag, [dynamic payload]) {
    String output;
    if (production) return log('');
    try {
      output = generator('=', tag, jsonPretty(json.decode(payload)));
    } catch (e) {
      output = generator('=', tag, payload);
    }

    log(output);
  }

  void error(String tag, [dynamic payload]) {
    if (production) return log('');
    final output = generator('*', tag, payload);
    log(output);
  }

  @visibleForTesting
  String generator(String delime, String tag, [dynamic payload]) {
    if (production) return '';
    var _ = '';

    final _d = delime.padRight(20, delime);
    _ += '\n$delime> $tag $_d>\n';
    if (payload != null) {
      _ += '$payload \n$_d\n';
    }

    return _;
  }

  static String _stringifyMessage(Object? message) {
    const decoder = JsonDecoder();
    const encoder = JsonEncoder.withIndent(' ');
    try {
      final raw = decoder.convert(message.toString());
      return encoder.convert(raw);
    } catch (e) {
      return message.toString();
    }
  }
}
