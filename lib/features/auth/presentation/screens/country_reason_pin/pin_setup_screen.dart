import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:pinput/pinput.dart';

class PinSetupScreen extends StatefulWidget {
  const PinSetupScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> with FormMixin {
  AuthParams requestDto = AuthParams.empty();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const CustomAppBar(
        leading: AppBoxedButton(),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Set your PIN code',
                style: context.textTheme.headlineLarge!.copyWith(
                  color: AppColors.textHeaderColor,
                  fontWeight: FontWeight.w700,
                  fontSize: Insets.dim_24,
                ),
                textAlign: TextAlign.start,
              ),
              const YBox(Insets.dim_8),
              Text(
                'We use state-of-the-art security measures to protect your information at all times',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.textBodyColor,
                  fontWeight: FontWeight.w400,
                  fontSize: Insets.dim_16,
                ),
                textAlign: TextAlign.start,
              ),
              const YBox(Insets.dim_40),
              PinTextField(
                onSaved: (input) {},
                inputDecoration: const PinTheme(
                  height: 60,
                  width: 60,
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: AppColors.textHeaderColor,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.appGreen,
                      ),
                    ),
                  ),
                ),
              ),
              YBox(context.getHeight(0.12)),
              AppSolidButton(
                textTitle: 'Create PIN',
                action: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
