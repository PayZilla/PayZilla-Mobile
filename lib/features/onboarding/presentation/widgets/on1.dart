import 'package:flutter/material.dart';
import 'package:pay_zilla/features/ui_widgets/image.dart';
import 'package:pay_zilla/functional_utils/assets.dart';
import 'package:pay_zilla/functional_utils/extensions/context_extension.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF068394),
            Color(0x57068394),
            Color(0x17068394),
            Color(0x00068394)
          ],
        ),
        shape: Border(),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 113,
            top: 333,
            child: Container(),
          ),
          const Positioned(
            left: 0,
            top: 778,
            child: SizedBox(width: 375, height: 34),
          ),
          Positioned(
            left: 63,
            top: 20.05,
            child: Transform(
              transform: Matrix4.identity()
                ..translate(0.0)
                ..rotateZ(-0.34),
              child: Container(
                width: 375,
                height: 494,
                decoration: const ShapeDecoration(
                  color: Color(0x3AE6F6F7),
                  shape: OvalBorder(),
                ),
              ),
            ),
          ),
          Positioned(
            left: -94,
            top: 14.49,
            child: Transform(
              transform: Matrix4.identity()
                ..translate(0.0)
                ..rotateZ(-0.34),
              child: Container(
                width: 160.41,
                height: 158.25,
                decoration: const ShapeDecoration(
                  color: Color(0x3AE6F6F7),
                  shape: OvalBorder(),
                ),
              ),
            ),
          ),
          // Image of the person
          Positioned(
            left: context.getWidth() * 0.12,
            top: context.getHeight() * 0.25,
            child: SizedBox(
              width: 324.17,
              child: Stack(
                children: [
                  Positioned(
                    left: 15.17,
                    top: 344.94,
                    child: Container(
                      width: 300.98,
                      height: 90.76,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF233F78).withOpacity(0.1),
                        shape: const OvalBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Center(
                      child: LocalImage(onb1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Logo with Name
          Positioned(
            left: context.getWidth() * 0.15,
            top: context.getHeight() * 0.75,
            child: SizedBox(
              height: 97,
              child: LocalImage(logoWithNamePng),
            ),
          ),
          // Just Logo
          Positioned(
            left: context.getWidth() * 0.5,
            top: context.getHeight() * 0.050,
            child: SizedBox(
              width: context.getWidth() * 0.5,
              child: LocalImage(logoPng),
            ),
          ),
        ],
      ),
    );
  }
}
