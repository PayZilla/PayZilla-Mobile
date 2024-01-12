import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class GenericTokenVerificationArgs {
  GenericTokenVerificationArgs({
    required this.email,
    required this.path,
    required this.endpointPath,
  });

  final String email;
  final String path;
  final String endpointPath;
}

class GenericTokenVerification extends StatefulWidget {
  const GenericTokenVerification({Key? key, required this.args})
      : super(key: key);
  final GenericTokenVerificationArgs args;

  @override
  State<GenericTokenVerification> createState() =>
      _GenericTokenVerificationState();
}

class _GenericTokenVerificationState extends State<GenericTokenVerification>
    with FormMixin, OtpTimeoutMixin {
  AuthParams requestDto = AuthParams.empty();
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      // only use this when coming from sign-up screen
      if (widget.args.email.contains('@') &&
          widget.args.endpointPath.contains('email-verification')) {
        await context.read<AuthProvider>().emailVerificationInitiate(context);
      } else if (widget.args.email.contains('@') &&
          widget.args.endpointPath.contains('forgot-password')) {
        requestDto = requestDto.copyWith(email: widget.args.email);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return AppScaffold(
      appBar: CustomAppBar(
        leading: AppBoxedButton(
          onPressed: () =>
              AppNavigator.of(context).push(AppRoutes.onboardingAuth),
        ),
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
                validator: (input) => Validators.validateString()(input),
                onSaved: (input) {
                  requestDto = requestDto.copyWith(token: input);
                },
              ),
              const YBox(Insets.dim_48),
              Center(
                child: InkWell(
                  onTap: () {
                    if (isTimerExpired && !provider.onboardingResp.isLoading) {
                      resetTimer();
                      provider.emailVerificationInitiate(context);
                    }
                  },
                  child: Text(
                    widget.args.email.toLowerCase() == 'your bvn data'
                        ? ''
                        : getCurrentOtpTimeoutCount(),
                    style: const TextStyle(
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
                deActivate: provider.onboardingResp.isLoading,
                showLoading: provider.onboardingResp.isLoading,
                action: () {
                  requestDto =
                      requestDto.copyWith(tokenRoute: widget.args.endpointPath);

                  validate(
                    () => provider.tokenVerification(
                      requestDto,
                      context,
                      widget.args.path,
                      endpointPath: widget.args.endpointPath,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
