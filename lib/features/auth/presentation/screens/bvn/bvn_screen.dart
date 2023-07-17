import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
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
        leading: Padding(
          padding: const EdgeInsets.only(left: Insets.dim_24),
          child: AppBoxedButton(
            onPressed: () => AppNavigator.of(context).pop(),
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
              child: Column(
                children: [
                  const YBox(Insets.dim_24),
                  verificationWidget(context, bvnSvg, 'BVN'),
                  const Divider(),
                  const YBox(Insets.dim_24),
                  verificationWidget(
                    context,
                    bvnSvg,
                    'Passport',
                    show: false,
                  ),
                  const YBox(Insets.dim_24),
                  verificationWidget(
                    context,
                    idCardSvg,
                    'Identity Card',
                    show: false,
                  ),
                  const YBox(Insets.dim_24),
                  const Divider(),
                  const YBox(Insets.dim_12),
                  verificationWidget(
                    context,
                    driverLicenseSvg,
                    'Driver LieLicense ',
                    show: false,
                  ),
                  const YBox(Insets.dim_24),
                ],
              ),
            ),
            const Spacer(),
            AppSolidButton(
              textTitle: 'Verify Identity',
              showLoading: provider.genericAuthResp.isLoading,
              action: () {
                AppNavigator.of(context).push(AppRoutes.bvnToReasons);
              },
            ),
            const YBox(Insets.dim_26),
          ],
        ),
      ),
    );
  }

  ListTile verificationWidget(
    BuildContext context,
    String asset,
    String title, {
    bool show = true,
  }) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(13),
        decoration: const BoxDecoration(
          color: Color(0xffEEEEEE),
          shape: BoxShape.circle,
        ),
        child: LocalSvgImage(asset),
      ),
      title: Row(
        children: [
          Text(
            title,
            style: context.textTheme.headlineLarge!.copyWith(
              color: AppColors.textHeaderColor,
              fontWeight: FontWeight.w700,
              fontSize: Insets.dim_16,
            ),
            textAlign: TextAlign.start,
          ),
          if (show) ...[
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
          ]
        ],
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: Insets.dim_18,
      ),
    );
  }
}
