import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class VerifyEmailOtpRecoveryArgs {
  VerifyEmailOtpRecoveryArgs(this.email, this.path);

  final String email;
  final String path;
}

class VerifyEmailOtpRecovery extends StatefulWidget {
  const VerifyEmailOtpRecovery({Key? key, required this.args})
      : super(key: key);
  final VerifyEmailOtpRecoveryArgs args;

  @override
  State<VerifyEmailOtpRecovery> createState() => _VerifyEmailOtpRecoveryState();
}

class _VerifyEmailOtpRecoveryState extends State<VerifyEmailOtpRecovery>
    with FormMixin {
  AuthParams requestDto = AuthParams.empty();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return AppScaffold(
      appBar: const CustomAppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: Insets.dim_24),
          child: AppBoxedButton(),
        ),
        leadingWidth: 80,
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
                'Verify it’s you',
                style: context.textTheme.headlineLarge!.copyWith(
                  color: AppColors.textHeaderColor,
                  fontWeight: FontWeight.w700,
                  fontSize: Insets.dim_24,
                ),
                textAlign: TextAlign.start,
              ),
              const YBox(Insets.dim_8),
              Text(
                'We send a code to ( ${widget.args.email} ). Enter it here to verify your identity',
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
              ),
              const YBox(Insets.dim_48),
              Center(
                child: InkWell(
                  onTap: () {},
                  child: const Text(
                    'Resend Code',
                    style: TextStyle(
                      color: AppColors.appSecondaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: Insets.dim_16,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              YBox(context.getHeight(0.12)),
              AppSolidButton(
                textTitle: 'Confirm',
                showLoading: provider.genericAuthResp.isLoading,
                action: () {
                  AppNavigator.of(context).push(widget.args.path);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
