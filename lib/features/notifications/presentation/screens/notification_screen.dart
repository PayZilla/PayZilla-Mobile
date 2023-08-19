import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/notifications/notifications.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/assets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notProvider = context.watch<NotificationProvider>();
    return AppScaffold(
      extendedBody: true,
      useBodyPadding: false,
      appBar: CustomAppBar(
        centerTitle: true,
        appBarTitleColor: AppColors.black,
        title: 'Notification',
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: Insets.dim_24),
          child: AppBoxedButton(
            onPressed: () => AppNavigator.of(context).pop(),
          ),
        ),
        actions: [
          AppBoxedButton(
            width: 60,
            onPressed: () {},
            icon: LocalSvgImage(notificationCheckSvg),
          ),
          const XBox(Insets.dim_16)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.dim_16),
        child: ListView(
          children: [
            const YBox(Insets.dim_24),
            Text(
              'Today',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.textBodyColor,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                letterSpacing: 0.30,
              ),
            ),
            const YBox(Insets.dim_6),
            ...List.generate(
              2,
              (index) => AppListTileWidget(
                args: ListTileWidgetArgs(
                  asset: notProvider.notificationList[index].asset,
                  title: notProvider.notificationList[index].title,
                  subtitle: Text(notProvider.notificationList[index].subtitle),
                  trailing: Text(notProvider.notificationList[index].time),
                ),
              ),
            ),
            const YBox(Insets.dim_24),
            Text(
              'This Week',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.textBodyColor,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                letterSpacing: 0.30,
              ),
            ),
            const YBox(Insets.dim_6),
            ...List.generate(
              notProvider.notificationList.length,
              (index) => AppListTileWidget(
                args: ListTileWidgetArgs(
                  asset: notProvider.notificationList[index].asset,
                  title: notProvider.notificationList[index].title,
                  subtitle: Text(notProvider.notificationList[index].subtitle),
                  trailing: Text(notProvider.notificationList[index].time),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
