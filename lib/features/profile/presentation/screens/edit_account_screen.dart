import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/profile/profile.dart';
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
    final profileProvider = context.read<ProfileProvider>();
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
        leading: AppBoxedButton(
          onPressed: () => AppNavigator.of(context).pop(),
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
              AppTextFormField(
                labelDistance: Insets.dim_16,
                initialValue:
                    '${provider.user.firstName} ${provider.user.lastName}',
                enabled: false,
                labelText: 'Your name',
              ),
              const YBox(Insets.dim_24),
              AppTextFormField(
                labelDistance: Insets.dim_16,
                initialValue: provider.user.occupation,
                hintText: 'Enter current occupation',
                labelText: 'Occupation',
                isLoading: profileProvider.userProfileUpdate.isLoading,
                inputType: TextInputType.emailAddress,
                onSaved: (value) {
                  requestDto = requestDto.copyWith(occupation: value);
                },
                validator: (input) => Validators.validateString()(input),
              ),
              const YBox(Insets.dim_24),
              AppTextFormField(
                labelDistance: Insets.dim_16,
                initialValue: provider.user.employer,
                hintText: 'Enter company name',
                labelText: 'Employer',
                isLoading: profileProvider.userProfileUpdate.isLoading,
                inputType: TextInputType.emailAddress,
                onSaved: (value) {
                  requestDto = requestDto.copyWith(employer: value);
                },
                validator: (input) => Validators.validateString()(input),
              ),
              const YBox(Insets.dim_24),
              PhoneNumberTextFormField(
                key: ValueKey(requestDto.phoneNumber),
                initialValue: provider.user.phoneNumber,
                enabled: false,
                labelText: 'Phone number',
              ),
              const YBox(Insets.dim_24),
              AppTextFormField(
                labelDistance: Insets.dim_16,
                initialValue: provider.user.email,
                labelText: 'Email',
                enabled: false,
              ),
              YBox(context.getHeight(0.09)),
              AppSolidButton(
                textTitle: 'Save',
                showLoading: profileProvider.userProfileUpdate.isLoading,
                action: () {
                  validate(() async {
                    await profileProvider
                        .profileUpdate(requestDto, context)
                        .then((value) {
                      if (profileProvider.userProfileUpdate.isSuccess) {
                        AppNavigator.of(context).push(AppRoutes.home);
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
