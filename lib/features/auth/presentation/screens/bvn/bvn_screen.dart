import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class BvnScreen extends StatefulWidget {
  const BvnScreen({Key? key}) : super(key: key);

  @override
  State<BvnScreen> createState() => _BvnScreenState();
}

class _BvnScreenState extends State<BvnScreen> with FormMixin {
  AuthParams requestDto = AuthParams.empty();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return AppScaffold(
      appBar: CustomAppBar(
        leading: AppBoxedButton(
          onPressed: () => AppNavigator.of(context).pop(),
        ),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verification',
              style: context.textTheme.headlineLarge!.copyWith(
                color: AppColors.textHeaderColor,
                fontWeight: FontWeight.w700,
                fontSize: Insets.dim_24,
              ),
              textAlign: TextAlign.start,
            ),
            const YBox(Insets.dim_8),
            Text(
              'Method of verification',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.textBodyColor,
                fontWeight: FontWeight.w400,
                fontSize: Insets.dim_16,
              ),
              textAlign: TextAlign.start,
            ),
            const YBox(Insets.dim_40),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.borderColor, width: 2),
                borderRadius: BorderRadius.circular(Insets.dim_20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.borderColor,
                    spreadRadius: 2,
                    blurRadius: 20,
                    offset: const Offset(-0, 10),
                    blurStyle: BlurStyle.inner,
                  )
                ],
              ),
              child: ExpansionTile(
                initiallyExpanded: true,
                iconColor: AppColors.btnPrimaryColor,
                childrenPadding:
                    const EdgeInsets.symmetric(horizontal: Insets.dim_16),
                leading: Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.all(13),
                  decoration: const BoxDecoration(
                    color: Color(0xffEEEEEE),
                    shape: BoxShape.circle,
                  ),
                  child: LocalSvgImage(bvnSvg),
                ),
                title: ListTile(
                  title: Row(
                    children: [
                      Text(
                        'BVN',
                        style: context.textTheme.headlineLarge!.copyWith(
                          color: AppColors.textHeaderColor,
                          fontWeight: FontWeight.w700,
                          fontSize: Insets.dim_16,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Insets.dim_14,
                        ),
                        child: Icon(
                          Icons.star,
                          color: AppColors.borderErrorColor,
                          size: 16,
                        ),
                      ),
                      Text(
                        '(mandatory field)',
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: AppColors.textBodyColor,
                          fontWeight: FontWeight.w300,
                          fontSize: Insets.dim_12,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                children: [
                  const YBox(Insets.dim_24),
                  PhoneNumberTextFormField(
                    key: const ValueKey('123'),
                    initialValue: requestDto.bvn,
                    hintText: '232********',
                    labelText: 'BVN',
                    onSaved: (bvn) {
                      requestDto = requestDto.copyWith(
                        bvn: bvn,
                      );
                    },
                  ),
                  const YBox(Insets.dim_18),
                  ClickableFormField(
                    labelText: 'Date Of Birth',
                    hintText: 'Select date',
                    key: const ValueKey('456'),
                    controller: TextEditingController(text: requestDto.dob),
                    validator: (input) => Validators.validateString(
                      error: 'This field is required',
                    )(input),
                    onPressed: () {
                      unawaited(
                        DatePickerUtil.adaptive(
                          context,
                          isDateOfBirth: true,
                          onDateTimeChanged: (date) {
                            setState(() {
                              requestDto = requestDto.copyWith(
                                dob: DateFormatUtil.formatDate(
                                  apiRangeFormat,
                                  date.toString(),
                                ),
                              );
                            });
                          },
                        ),
                      );
                    },
                    suffixIcon: const Icon(
                      PhosphorIcons.calendarBlank,
                      size: 18,
                    ),
                  ),
                  const YBox(Insets.dim_18),
                ],
              ),
            ),
            const Spacer(),
            AppSolidButton(
              textTitle: 'Verify Identity',
              showLoading: provider.onboardingResp.isLoading,
              action: () {
                validate(
                  () {
                    provider.initializeBvn(requestDto, context).then((value) {
                      if (provider.onboardingResp.isSuccess) {
                        AppNavigator.of(context).push(
                          AppRoutes.pin,
                          args: GenericTokenVerificationArgs(
                            'your BVN data',
                            AppRoutes.bvnToReasons,
                            authEndpoints.bvnVerification,
                          ),
                        );
                      }
                    });
                  },
                );
              },
            ),
            const YBox(Insets.dim_26),
          ],
        ),
      ),
    );
  }
}
