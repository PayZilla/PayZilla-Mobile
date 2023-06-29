import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/onboarding/onboarding.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
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
        alignment: Alignment.bottomCenter,
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
          if (provider.currentValue != 0) ...[
            Positioned(
              right: 30,
              top: 50,
              child: TextButton(
                onPressed: () => provider.pushToAuthScreen(context),
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
            Padding(
              padding: const EdgeInsets.only(
                left: Insets.dim_60,
                right: Insets.dim_60,
                bottom: Insets.dim_80,
              ),
              child: AppGradientButton(
                textTitle: 'Get Started',
                action: () => provider.pushToAuthScreen(context),
              ),
            ),
          ],
          Padding(
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
          )
        ],
      ),
    );
  }
}
