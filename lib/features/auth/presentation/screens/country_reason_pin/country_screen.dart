import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({Key? key}) : super(key: key);

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> with FormMixin {
  AuthParams requestDto = AuthParams.empty();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return AppScaffold(
      appBar: CustomAppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: Insets.dim_24),
          child: AppBackButton(
            onPressed: () =>
                AppNavigator.of(context).push(AppRoutes.onboardingAuth),
          ),
        ),
        leadingWidth: 80,
      ),
      body: Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Country of Residence',
              style: context.textTheme.headlineLarge!.copyWith(
                color: AppColors.textHeaderColor,
                fontWeight: FontWeight.w700,
                fontSize: Insets.dim_24,
              ),
              textAlign: TextAlign.start,
            ),
            const YBox(Insets.dim_8),
            Text(
              'Please select all the countries that you’re a tax resident in',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.textBodyColor,
                fontWeight: FontWeight.w400,
                fontSize: Insets.dim_16,
              ),
              textAlign: TextAlign.start,
            ),
            const YBox(Insets.dim_40),
            ClickableFormField(
              hintText: 'Select country',
              validator: (input) => Validators.validateString()(input),
              onPressed: () async {
                await provider.showCountry(context: context).show(context);
              },
            ),
            const Spacer(),
            AppSolidButton(
              textTitle: 'Continue',
              showLoading: provider.genericAuthResp.isLoading,
              action: () =>
                  AppNavigator.of(context).push(AppRoutes.countryToBvn),
            ),
            const YBox(Insets.dim_26),
          ],
        ),
      ),
    );
  }
}
