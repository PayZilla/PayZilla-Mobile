import 'package:flutter/foundation.dart';
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
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: Form(
              key: formKey,
              autovalidateMode: autoValidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Login',
                    style: context.textTheme.headlineLarge!
                        .apply(color: AppColors.textHeaderColor),
                    textAlign: TextAlign.start,
                  ),
                  const YBox(Insets.dim_8),
                  Text(
                    'Enter your details to login ',
                    style: context.textTheme.bodyMedium!.apply(
                      color: AppColors.textBodyColor,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const YBox(Insets.dim_40),
                  AppTextFormField(
                    initialValue: requestDto.email,
                    labelText: 'Email',
                    hintText: 'name@example.com',
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
                    labelText: 'Password',
                    hintText: 'Your Password',
                    isLoading: provider.genericAuthResp.isLoading,
                    inputType: TextInputType.text,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      child: Container(
                        height: Insets.dim_24.dx,
                        width: Insets.dim_50,
                        margin: const EdgeInsets.symmetric(
                          vertical: Insets.dim_8,
                          horizontal: Insets.dim_4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F2F7),
                          borderRadius: BorderRadius.circular(Insets.dim_4),
                        ),
                        child: Center(
                          child: Text(
                            obscurePassword ? 'Show' : 'Hide',
                            style: context.textTheme.bodyMedium!
                                .apply(color: AppColors.textBodyColor),
                          ),
                        ),
                      ),
                    ),
                    obscureText: obscurePassword,
                    onSaved: (value) {
                      requestDto = requestDto.copyWith(password: value);
                    },
                    validator: (input) => Validators.validatePassword()(input),
                  ),
                  YBox(Dims.deviceSize.height / 2.2),
                  AppSolidButton(
                    textTitle: 'Continue',
                    showLoading: provider.genericAuthResp.isLoading,
                    action: () async {
                      if (kDebugMode) {
                        final formState = formKey.currentState;
                        formState?.save();
                        await provider.login(
                          requestDto.copyWith(
                            email: requestDto.email.isEmpty
                                ? 'jboy9140@yahoo.com'
                                : requestDto.email,
                            password: requestDto.password.isEmpty
                                ? '.joshThings1@'
                                : requestDto.password,
                          ),
                          context,
                        );
                      } else {
                        validate(() async {
                          await provider.login(requestDto, context);
                        });
                      }
                    },
                  ),
                  const YBox(Insets.dim_16),
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
                            style:
                                Theme.of(context).textTheme.bodyMedium!.apply(
                                      color: const Color(0xff7165E3),
                                      fontWeightDelta: 2,
                                    ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                AppNavigator.of(context).push(AppRoutes.signUp);
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
