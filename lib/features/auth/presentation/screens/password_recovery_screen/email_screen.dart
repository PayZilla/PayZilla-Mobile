import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class EmailRecovery extends StatefulWidget {
  const EmailRecovery({Key? key}) : super(key: key);

  @override
  State<EmailRecovery> createState() => _EmailRecoveryState();
}

class _EmailRecoveryState extends State<EmailRecovery> with FormMixin {
  AuthParams requestDto = AuthParams.empty();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return AppScaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              LocalSvgImage(recoverySvg),
              const YBox(Insets.dim_40),
              Text(
                'Password Recovery',
                style: context.textTheme.headlineLarge!.copyWith(
                  color: AppColors.textHeaderColor,
                  fontWeight: FontWeight.w700,
                  fontSize: Insets.dim_24,
                ),
                textAlign: TextAlign.start,
              ),
              const YBox(Insets.dim_8),
              Text(
                'Enter your registered email below to receive password instructions',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.textBodyColor,
                  fontWeight: FontWeight.w400,
                  fontSize: Insets.dim_16,
                ),
                textAlign: TextAlign.start,
              ),
              const YBox(Insets.dim_40),
              AppTextFormField(
                initialValue: requestDto.email,
                hintText: 'Email',
                isLoading: provider.onboardingResp.isLoading,
                inputType: TextInputType.emailAddress,
                onSaved: (value) {
                  requestDto = requestDto.copyWith(email: value);
                },
                validator: (input) => Validators.validateEmail(
                  value: input,
                ),
              ),
              const YBox(Insets.dim_40),
              AppSolidButton(
                textTitle: 'Send me email',
                showLoading: provider.onboardingResp.isLoading,
                action: () {
                  validate(() async {
                    await provider.forgotPasswordInit(requestDto).then((value) {
                      if (provider.onboardingResp.isSuccess) {
                        AppNavigator.of(context).push(
                          AppRoutes.recoveryToVerify,
                          args: GenericTokenVerificationArgs(
                            requestDto.email,
                            AppRoutes.verifyToPassword,
                            authEndpoints.forgotPasswordVerify,
                          ),
                        );
                      }
                    });
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
