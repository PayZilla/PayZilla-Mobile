import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class EditAccountInfoScreen extends StatefulWidget {
  const EditAccountInfoScreen({Key? key}) : super(key: key);

  @override
  State<EditAccountInfoScreen> createState() => _EditAccountInfoScreenState();
}

class _EditAccountInfoScreenState extends State<EditAccountInfoScreen>
    with FormMixin {
  AuthParams requestDto = AuthParams.empty();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return AppScaffold(
      appBar: CustomAppBar(
        titleWidget: Text(
          'Edit Account',
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 0.30,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: Insets.dim_24),
          child: AppBoxedButton(
            onPressed: () => AppNavigator.of(context).pop(),
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
              AppTextFormField(
                labelDistance: Insets.dim_16,
                initialValue: requestDto.email,
                hintText: 'Full name',
                labelText: 'Your name',
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
              ClickableFormField(
                hintText: 'Select Occupation',
                labelText: 'Occupation',
                validator: (input) => Validators.validateString()(input),
                onPressed: () async {
                  await provider.showCountry(context: context).show(context);
                },
              ),
              const YBox(Insets.dim_24),
              AppTextFormField(
                labelDistance: Insets.dim_16,
                initialValue: requestDto.email,
                hintText: 'Enter company name',
                labelText: 'Employer',
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
              PhoneNumberTextFormField(
                key: ValueKey(requestDto.phoneNumber),
                initialValue: requestDto.phoneNumber,
                labelText: 'Phone number',
                labelDistance: Insets.dim_16,
                hintText: '081xxxxxxxx',
                onSaved: (phoneNumber) {
                  requestDto = requestDto.copyWith(
                    phoneNumber: phoneNumber,
                  );
                },
              ),
              const YBox(Insets.dim_24),
              AppTextFormField(
                labelDistance: Insets.dim_16,
                initialValue: requestDto.email,
                hintText: 'Email',
                labelText: 'Email',
                isLoading: provider.genericAuthResp.isLoading,
                inputType: TextInputType.emailAddress,
                onSaved: (value) {
                  requestDto = requestDto.copyWith(email: value);
                },
                validator: (input) => Validators.validateEmail(
                  value: input,
                ),
              ),
              YBox(context.getHeight(0.09)),
              AppSolidButton(
                textTitle: 'Save',
                showLoading: provider.genericAuthResp.isLoading,
                action: () =>
                    AppNavigator.of(context).push(AppRoutes.accountInfo),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
