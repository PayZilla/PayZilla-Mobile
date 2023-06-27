import 'dart:math';

import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/dots_indicator/dots_decorator.dart';
import 'package:flutter/material.dart';

typedef OnTap = void Function(double position);

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({
    Key? key,
    required this.dotsCount,
    this.position = 0.0,
    this.decorator = const DotsDecorator(),
    this.axis = Axis.horizontal,
    this.reversed = false,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.onTap,
  })  : assert(dotsCount > 0, 'Dot count should be greater than 0'),
        assert(position >= 0, 'Position count should be greater than 0'),
        assert(
          position < dotsCount,
          // ignore: prefer_single_quotes
          "Position must be inferior than dotsCount",
        ),
        super(key: key);
  final int dotsCount;
  final double position;
  final DotsDecorator decorator;
  final Axis axis;
  final bool reversed;
  final OnTap? onTap;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;

  Widget _buildDot(int index) {
    final state = min(1, (position - index).abs()).toDouble();

    final size = Size.lerp(decorator.activeSize, decorator.size, state)!;
    final color = Color.lerp(decorator.activeColor, decorator.color, state);

    final dot = AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: position == index ? color : color!.withOpacity(0.4),
        borderRadius: BorderRadius.circular(3),
      ),
    );
    return onTap == null
        ? dot
        : InkWell(
            customBorder: const CircleBorder(),
            onTap: () => onTap!(index.toDouble()),
            child: dot,
          );
  }

  @override
  Widget build(BuildContext context) {
    final dotsList = List<Widget>.generate(dotsCount, _buildDot);
    final dots = reversed == true ? dotsList.reversed.toList() : dotsList;

    return axis == Axis.vertical
        ? Column(
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: dots,
          )
        : Wrap(
            alignment: WrapAlignment.center,
            children: dots,
          );
  }
}
