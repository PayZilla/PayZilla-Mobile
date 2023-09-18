import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final profileProvider = context.watch<ProfileProvider>();
    return AppScaffold(
      useBodyPadding: false,
      appBar: CustomAppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: Insets.dim_24),
          child: AppBoxedButton(
            onPressed: () {
              AppNavigator.of(context).push(AppRoutes.profile);
            },
          ),
        ),
        leadingWidth: 80,
        titleWidget: Text(
          'Account Info',
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 0.30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.dim_24),
        child: ListView(
          children: [
            Center(
              child: profileProvider.profileLoader
                  ? CupertinoActivityIndicator.partiallyRevealed(
                      radius: context.getHeight(0.03),
                    )
                  : Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(Insets.dim_12),
                          height: context.getHeight(0.18),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    AppColors.textBodyColor.withOpacity(0.05),
                                blurRadius: 10,
                                spreadRadius: 10,
                              )
                            ],
                          ),
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: HostedImage(
                              authProvider.user.profileImage,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          height: Insets.dim_40,
                          width: Insets.dim_40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.btnPrimaryColor,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: AppColors.white,
                          ),
                        )
                      ],
                    ),
            ).onTap(() async {
              final pickedImage =
                  await const ChooseUploadOption().show<XFile>(context);
              if (pickedImage != null) {
                await profileProvider.uploadImage(pickedImage.path);
                setState(() {});
              }
            }),
            const YBox(Insets.dim_16),
            Text(
              'Personal Info',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.textBodyColor,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                letterSpacing: 0.30,
              ),
            ),
            const YBox(Insets.dim_16),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: Corners.mdBorder,
                border: Border.all(color: AppColors.grey),
              ),
              child: Column(
                children: [
                  rowBoxContent(
                    context,
                    'Your name',
                    subtitle:
                        '${authProvider.user.firstName} ${authProvider.user.lastName}',
                  ),
                  rowBoxContent(
                    context,
                    'Occupation',
                    subtitle: authProvider.user.occupation,
                  ),
                  rowBoxContent(
                    context,
                    'Employer',
                    subtitle: authProvider.user.employer,
                  ),
                  rowBoxContent(
                    context,
                    'NG Citizen',
                    subWidget: CupertinoSwitch(value: true, onChanged: (v) {}),
                  ),
                ],
              ),
            ),
            const YBox(Insets.dim_16),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: Corners.mdBorder,
                border: Border.all(color: AppColors.grey),
              ),
              child: rowBoxContent(
                context,
                'Email',
                subtitle: authProvider.user.email,
              ),
            ),
            YBox(context.getHeight(0.05)),
            AppButton(
              textTitle: 'Edit',
              action: () =>
                  AppNavigator.of(context).push(AppRoutes.editAccountInfo),
              backgroundColor: AppColors.grey,
              color: AppColors.textHeaderColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget rowBoxContent(
    BuildContext context,
    String title, {
    Widget? subWidget,
    String subtitle = '',
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Insets.dim_24,
        horizontal: Insets.dim_24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textBodyColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 0.30,
            ),
          ),
          const XBox(Insets.dim_24),
          subWidget ??
              Expanded(
                child: Text(
                  subtitle,
                  textAlign: TextAlign.end,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textHeaderColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
