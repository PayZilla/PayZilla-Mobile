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
        leading: AppBoxedButton(
          onPressed: () {
            AppNavigator.of(context).push(AppRoutes.profile);
          },
        ),
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
          AppListTileWidget(
            args: ListTileWidgetArgs(
              asset: defaultNotificationSvg,
              title: 'Default Notification Actions',
            ),
          ),
          AppListTileWidget(
            args: ListTileWidgetArgs(
              asset: generalSvg,
              assetColor: AppColors.appGreen,
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
          AppListTileWidget(
            args: ListTileWidgetArgs(
              trailing: CupertinoSwitch(
                onChanged: (value) {},
                value: true,
                activeColor: AppColors.appGreen,
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
          AppListTileWidget(
            args: ListTileWidgetArgs(
              trailing: CupertinoSwitch(
                onChanged: (value) {},
                value: false,
                activeColor: AppColors.appGreen,
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
          AppListTileWidget(
            args: ListTileWidgetArgs(
              trailing: CupertinoSwitch(
                onChanged: (value) {},
                value: true,
                activeColor: AppColors.appGreen,
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
