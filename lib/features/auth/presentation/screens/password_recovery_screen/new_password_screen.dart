import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> with FormMixin {
  AuthParams requestDto = AuthParams.empty();
  bool obscurePassword = true;
  bool obscurePassword2 = true;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return AppScaffold(
      appBar: CustomAppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: Insets.dim_24),
          child: AppBoxedButton(
            onPressed: () =>
                AppNavigator.of(context).push(AppRoutes.onboarding),
          ),
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
                'Create New Password',
                style: context.textTheme.headlineLarge!.copyWith(
                  color: AppColors.textHeaderColor,
                  fontWeight: FontWeight.w700,
                  fontSize: Insets.dim_24,
                ),
                textAlign: TextAlign.start,
              ),
              const YBox(Insets.dim_8),
              Text(
                'Please, enter a new password below different from the previous password',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.textBodyColor,
                  fontWeight: FontWeight.w400,
                  fontSize: Insets.dim_16,
                ),
                textAlign: TextAlign.start,
              ),
              const YBox(Insets.dim_40),
              AppTextFormField(
                initialValue: requestDto.password,
                hintText: 'Password',
                isLoading: provider.genericAuthResp.isLoading,
                inputType: TextInputType.text,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() => obscurePassword2 = !obscurePassword2);
                  },
                  color: AppColors.textBodyColor,
                  icon: Icon(
                    obscurePassword2
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                ),
                obscureText: obscurePassword2,
                onSaved: (value) {
                  requestDto = requestDto.copyWith(password: value);
                },
                validator: (input) => Validators.validatePassword()(input),
              ),
              const YBox(Insets.dim_24),
              AppTextFormField(
                initialValue: requestDto.password,
                hintText: 'Confirm password',
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
              YBox(context.getHeight(0.4)),
              AppSolidButton(
                textTitle: 'Create new password',
                showLoading: provider.genericAuthResp.isLoading,
                action: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
