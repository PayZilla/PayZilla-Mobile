import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class GeneralSettingsScreen extends StatelessWidget {
  const GeneralSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'General Settings',
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 0.30,
          ),
        ),
      ),
      body: Column(
        children: [
          const YBox(Insets.dim_40),
          ProfileListTileWidget(
            args: ProfileListTileWidgetArgs(
              asset: defaultNotificationSvg,
              title: 'Default Notification Actions',
            ),
          ),
          ProfileListTileWidget(
            args: ProfileListTileWidgetArgs(
              asset: generalSvg,
              assetColor: const Color(0xff1DAB87),
              title: 'Manage Notifications',
            ),
          ),
          const YBox(Insets.dim_24),
          Divider(
            color: AppColors.black.withOpacity(0.5),
            indent: Insets.dim_24,
            endIndent: Insets.dim_24,
          ),
          const YBox(Insets.dim_24),
          ProfileListTileWidget(
            args: ProfileListTileWidgetArgs(
              trailing: CupertinoSwitch(
                onChanged: (value) {},
                value: true,
                activeColor: const Color(0xff1DAB87),
              ),
              title: 'Manage Notifications',
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: Insets.dim_16),
                child: Text(
                  'You want to receive bill reminders before a bill is due.',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textBodyColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    letterSpacing: 0.30,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ),
          ProfileListTileWidget(
            args: ProfileListTileWidgetArgs(
              trailing: CupertinoSwitch(
                onChanged: (value) {},
                value: false,
                activeColor: const Color(0xff1DAB87),
              ),
              title: 'Bills Calendar',
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: Insets.dim_16),
                child: Text(
                  'You want to receive bill reminder emails before a bill is due.',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textBodyColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    letterSpacing: 0.30,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ),
          ProfileListTileWidget(
            args: ProfileListTileWidgetArgs(
              trailing: CupertinoSwitch(
                onChanged: (value) {},
                value: true,
                activeColor: const Color(0xff1DAB87),
              ),
              title: 'Credit Score Calendar',
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: Insets.dim_16),
                child: Text(
                  'You want to receive bill reminders before a bill is due.',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textBodyColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    letterSpacing: 0.30,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
