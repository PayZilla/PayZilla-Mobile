import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/onboarding/onboarding.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OnboardingProvider>().initiate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          PageView(
            controller: provider.welcomePageController,
            onPageChanged: provider.changeCurrentValue,
            children: List.generate(
              3,
              (index) {
                return provider.onboardingScreens[index];
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: Insets.dim_30),
              child: SmoothPageIndicator(
                controller: provider.welcomePageController,
                count: 3,
                effect: const ExpandingDotsEffect(
                  expansionFactor: 5,
                  dotHeight: 10,
                  dotWidth: 12,
                  activeDotColor: Color(0xFF233F78),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
