import 'package:flutter/services.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

extension StringExtension on String {
  int toInt() {
    try {
      return int.parse(this);
    } catch (e) {
      return -1;
    }
  }

  double toDouble() {
    try {
      return double.parse(this);
    } catch (e) {
      return -1;
    }
  }

  String camelToSnakeCase() {
    return split(RegExp('(?=[A-Z])')).join('_').toLowerCase();
  }

  String getInitials({int defaultLength = 2}) {
    try {
      if (isEmpty) return '';
      final names = split(' ');
      if (names.length < defaultLength) {
        return names[0][0].toUpperCase();
      }
      return names.sublist(0, defaultLength).map((name) {
        return name[0].toUpperCase();
      }).join();
    } catch (_) {
      return substring(0, 1).toUpperCase();
    }
  }

  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String toFilterDate() {
    return replaceAll('/', '-').split('-').reversed.toList().join('-');
  }

  String removeSpecialCharactersOnError() {
    return split(':').last.replaceAll(RegExp(r'[^\w\s]+'), '');
  }

  String toTitleCase() {
    if (length < 2) return this;
    return toLowerCase().split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  String redactRange(int start, int end, {String replacement = '•'}) {
    return replaceRange(start, end, replacement * (end - start));
  }

  String toUrlEncoded() {
    return Uri.encodeComponent(this);
  }

  void toClipboard({String feedbackMsg = 'Copied to clipboard'}) {
    Clipboard.setData(ClipboardData(text: this))
        .then((value) => showSuccessNotification(feedbackMsg))
        .catchError((_) {});
  }
}
