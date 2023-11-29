import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(3.seconds, () async {
        await context
            .read<AuthProvider>()
            .getUser(useNetworkCall: false, context: context)
            .then((value) {
          if (!value.isEmpty) {
            AppNavigator.of(context).push(AppRoutes.home);
          } else {
            AppNavigator.of(context).push(AppRoutes.onboarding);
          }
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: AppColors.white),
      child: Center(
        child: SizedBox(
          height: 192,
          child: LocalImage(
            logoWithNamePng,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
