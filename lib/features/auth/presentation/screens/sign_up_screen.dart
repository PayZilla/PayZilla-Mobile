import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with FormMixin {
  AuthParams requestDto = AuthParams.empty();
  bool obscurePassword = true;

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
              RichText(
                text: TextSpan(
                  text: 'Create a',
                  style: context.textTheme.headlineLarge!.copyWith(
                    color: AppColors.textHeaderColor,
                    fontWeight: FontWeight.w700,
                    fontSize: Insets.dim_24,
                  ),
                  children: [
                    TextSpan(
                      text: ' PayZilla\n',
                      style: context.textTheme.headlineLarge!.copyWith(
                        color: AppColors.appGreen,
                        fontWeight: FontWeight.w700,
                        fontSize: Insets.dim_24,
                      ),
                    ),
                    TextSpan(
                      text: 'account',
                      style: context.textTheme.headlineLarge!.copyWith(
                        color: AppColors.textHeaderColor,
                        fontWeight: FontWeight.w700,
                        fontSize: Insets.dim_24,
                      ),
                    ),
                  ],
                ),
              ),
              const YBox(Insets.dim_40),
              AppTextFormField(
                initialValue: requestDto.fullName,
                hintText: 'Full name',
                isLoading: provider.signUpAuthResp.isLoading,
                inputType: TextInputType.text,
                onSaved: (value) {
                  requestDto = requestDto.copyWith(fullName: value);
                },
                validator: (input) => Validators.validateFullName()(input),
              ),
              const YBox(Insets.dim_24),
              AppTextFormField(
                initialValue: requestDto.email,
                hintText: 'Email',
                isLoading: provider.signUpAuthResp.isLoading,
                inputType: TextInputType.emailAddress,
                onSaved: (value) {
                  requestDto = requestDto.copyWith(email: value);
                },
                validator: (input) => Validators.validateEmail(
                  value: input,
                ),
              ),
              const YBox(Insets.dim_24),
              PhoneNumberTextFormField(
                key: ValueKey(requestDto.phoneNumber),
                initialValue: requestDto.phoneNumber,
                hintText: 'Phone Number',
                onSaved: (phoneNumber) {
                  requestDto = requestDto.copyWith(
                    phoneNumber: phoneNumber,
                  );
                },
              ),
              const YBox(Insets.dim_24),
              AppTextFormField(
                initialValue: requestDto.password,
                hintText: 'Password',
                isLoading: provider.signUpAuthResp.isLoading,
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
              const YBox(Insets.dim_60),
              AppSolidButton(
                textTitle: 'Sign Up',
                showLoading: provider.signUpAuthResp.isLoading,
                action: () {
                  validate(() => provider.signUp(requestDto, context));
                },
              ),
              /*
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
                  socialAuthWidget(googleSvg, context),
                  const XBox(Insets.dim_24),
                  socialAuthWidget(appleSvg, context),
                ],
              ),
              YBox(context.getHeight(0.07)),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: context.textTheme.bodyMedium!.apply(
                      color: AppColors.textBodyColor,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: AppColors.appGreen,
                              fontWeightDelta: 2,
                            ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            AppNavigator.of(context)
                                .push(AppRoutes.onboardingAuth);
                          },
                      ),
                    ],
                  ),
                ),
              ),*/
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
