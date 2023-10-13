import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with FormMixin {
  AuthParams requestDto = AuthParams.empty();
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () async {
        final user =
            await context.read<AuthProvider>().getUser(useNetworkCall: false);
        if (!user.isEmpty) {
          requestDto = requestDto.copyWith(email: user.email);
        }
      },
    ).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return AppScaffold(
      appBar: CustomAppBar(
        leading: AppBoxedButton(
          onPressed: () => AppNavigator.of(context).push(AppRoutes.onboarding),
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
                'Hi There! 👋',
                style: context.textTheme.headlineLarge!.copyWith(
                  color: AppColors.textHeaderColor,
                  fontWeight: FontWeight.w700,
                  fontSize: Insets.dim_24,
                ),
                textAlign: TextAlign.start,
              ),
              const YBox(Insets.dim_8),
              Text(
                'Welcome back, Sign in to your account',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.textBodyColor,
                  fontWeight: FontWeight.w400,
                  fontSize: Insets.dim_16,
                ),
                textAlign: TextAlign.start,
              ),
              const YBox(Insets.dim_40),
              AppTextFormField(
                key: ValueKey(requestDto.email),
                initialValue: requestDto.email,
                hintText: 'Email',
                isLoading: provider.genericAuthResp.isLoading,
                inputType: TextInputType.emailAddress,
                onSaved: (value) {
                  requestDto = requestDto.copyWith(email: value);
                },
                validator: (input) => Validators.validateEmail(
                  value: input,
                ),
              ),
              const YBox(Insets.dim_24),
              AppTextFormField(
                initialValue: requestDto.password,
                hintText: 'Password',
                isLoading: provider.genericAuthResp.isLoading,
                inputType: TextInputType.text,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() => obscurePassword = !obscurePassword);
                  },
                  color: AppColors.textBodyColor,
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                ),
                obscureText: obscurePassword,
                onSaved: (value) {
                  requestDto = requestDto.copyWith(password: value);
                },
                validator: (input) => Validators.validatePassword()(input),
              ),
              const YBox(Insets.dim_26),
              InkWell(
                onTap: () {
                  AppNavigator.of(context).push(AppRoutes.authToRecovery);
                },
                child: const Text(
                  'Forgot your password?',
                  style: TextStyle(
                    color: AppColors.appSecondaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: Insets.dim_16,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              const YBox(Insets.dim_60),
              AppSolidButton(
                textTitle: 'Sign In',
                showLoading: provider.genericAuthResp.isLoading,
                action: () {
                  validate(() async {
                    await provider.login(requestDto, context);
                  });
                },
              ),
              const YBox(Insets.dim_26),
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Insets.dim_14),
                    child: Text(
                      'OR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textBodyColor,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Expanded(child: Divider())
                ],
              ),
              const YBox(Insets.dim_26),
              Row(
                children: [
                  socialAuthWidget(googleSvg),
                  const XBox(Insets.dim_24),
                  socialAuthWidget(appleSvg),
                ],
              ),
              YBox(context.getHeight(0.17)),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: context.textTheme.bodyMedium!.apply(
                      color: AppColors.textBodyColor,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: AppColors.appGreen,
                              fontWeightDelta: 2,
                            ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            AppNavigator.of(context)
                                .push(AppRoutes.authToSignUp);
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const YBox(Insets.dim_16),
              AppEnvManager.instance.getEnvironment().fold(
                    ifDevelopment: _showEnvName,
                    ifProduction: (env) => const SizedBox(),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showEnvName(String env) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: Text(
            'This is ${env.capitalize()} build',
            textAlign: TextAlign.center,
            style: const TextStyle(
              backgroundColor: Colors.red,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
