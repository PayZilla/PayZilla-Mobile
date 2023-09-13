import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class BiometricScreen extends StatefulWidget {
  const BiometricScreen({Key? key}) : super(key: key);

  @override
  State<BiometricScreen> createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> with FormMixin {
  AuthParams requestDto = AuthParams.empty();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return AppScaffold(
      body: Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const YBox(Insets.dim_40),
            Text(
              'Enable biometric Access',
              style: context.textTheme.headlineLarge!.copyWith(
                color: AppColors.textHeaderColor,
                fontWeight: FontWeight.w700,
                fontSize: Insets.dim_24,
              ),
              textAlign: TextAlign.center,
            ),
            const YBox(Insets.dim_8),
            Text(
              'Enter your registered email below to receive password instructions',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.textBodyColor,
                fontWeight: FontWeight.w400,
                fontSize: Insets.dim_16,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            LocalImage(biometricPng, height: context.getHeight(0.15)),
            YBox(context.getHeight(0.34)),
            AppSolidButton(
              textTitle: 'Enable biometric access',
              showLoading: provider.genericAuthResp.isLoading,
              action: () {
                provider.authRepository.biometricMode = true;
              },
            ),
            const YBox(Insets.dim_26),
            InkWell(
              onTap: () => AppNavigator.of(context).push(AppRoutes.home),
              child: const Text(
                'I’ll do this later',
                style: TextStyle(
                  color: AppColors.appSecondaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: Insets.dim_16,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
