import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle? {
  TextStyle get bold => this!.copyWith(fontWeight: FontWeight.w500);
  TextStyle size(double size) => this!.copyWith(fontSize: size);
}
