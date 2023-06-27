import 'package:pay_zilla/config/config.dart';
import 'package:flutter/material.dart';

const Size kDefaultSize = Size.square(Insets.dim_10);
const EdgeInsets kDefaultSpacing = EdgeInsets.all(Insets.dim_6);
const ShapeBorder kDefaultShape = CircleBorder();

class DotsDecorator {
  const DotsDecorator({
    this.color = Colors.grey,
    this.activeColor = Colors.lightBlue,
    this.size = kDefaultSize,
    this.activeSize = kDefaultSize,
    this.shape = kDefaultShape,
    this.activeShape = kDefaultShape,
    this.spacing = kDefaultSpacing,
  });

  /// Inactive dot color
  ///
  /// @Default `Colors.grey`
  final Color color;

  /// Active dot color
  ///
  /// @Default `Colors.lightBlue`
  final Color activeColor;

  /// Inactive dot size
  ///
  /// @Default `Size.square(9.0)`
  final Size size;

  /// Active dot size
  ///
  /// @Default `Size.square(9.0)`
  final Size activeSize;

  /// Inactive dot shape
  ///
  /// @Default `CircleBorder()`
  final ShapeBorder shape;

  /// Active dot shape
  ///
  /// @Default `CircleBorder()`
  final ShapeBorder activeShape;

  /// Spacing between dots
  ///
  /// @Default `EdgeInsets.all(6.0)`
  final EdgeInsets spacing;
}
