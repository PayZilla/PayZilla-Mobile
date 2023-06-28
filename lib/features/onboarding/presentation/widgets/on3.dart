import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/assets.dart';
import 'package:pay_zilla/functional_utils/extensions/context_extension.dart';

class OnboardingScreen3 extends StatefulWidget {
  const OnboardingScreen3({super.key});

  @override
  State<OnboardingScreen3> createState() => _OnboardingScreen3State();
}

class _OnboardingScreen3State extends State<OnboardingScreen3> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: 0.7,
          child: Container(
            color: AppColors.white,
            child: Stack(
              children: [
                Positioned(
                  top: context.getHeight(0.18), //phone image distance from top
                  left: context.getWidth(0.05),
                  child: LocalImage(
                    onb3,
                    height: context.getHeight(.7), //size of phone image asset
                  ),
                ),
                // top image position on phone image asset
                Positioned(
                  top: context.getHeight(0.24),
                  left: context.getWidth(0.01),
                  child: LocalImage(
                    onb3b,
                    height: context.getHeight(0.4),
                    width: context.getWidth(),
                  ),
                ),
                // top placeholder image position on name image asset
                Positioned(
                  top: context.getHeight(0.4),
                  right: context.getWidth(0.08),
                  child: LocalImage(
                    imgPlaceholder,
                    height: 70,
                    width: 70,
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            heightFactor: .4,
            alignment: Alignment.bottomCenter,
            child: Container(
              height: context.getHeight(0.5),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.borderColor.withOpacity(0.25),
                    spreadRadius: 10,
                    blurRadius: 50,
                    blurStyle: BlurStyle.solid,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const YBox(Insets.dim_40),
                  const Text(
                    'The fastest transaction\nprocess only here',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textHeaderColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: Insets.dim_66),
                    child: Text(
                      'Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textBodyColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const YBox(Insets.dim_80),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Insets.dim_60),
                    child: AppGradientButton(
                      textTitle: 'Get Started',
                      action: () {},
                    ),
                  ),
                  const YBox(Insets.dim_48),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 30,
          top: 50,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'SKIP',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
