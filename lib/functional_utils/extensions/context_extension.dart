import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double getHeight([double factor = 1]) {
    assert(factor != 0, 'factor must be greater than 0');
    return MediaQuery.of(this).size.height * factor;
  }

  double getWidth([double factor = 1]) {
    assert(factor != 0, 'factor must be greater than 0');
    return MediaQuery.of(this).size.width * factor;
  }

  double get height => getHeight();
  double get width => getWidth();

  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension WidgetExtension on Widget {
  Widget onTap(VoidCallback action, {bool opaque = true}) {
    return GestureDetector(
      behavior: opaque ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
      onTap: action,
      child: this,
    );
  }
}
