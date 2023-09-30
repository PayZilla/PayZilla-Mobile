import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/notifications/notifications.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
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
        leading: AppBoxedButton(
          onPressed: () => AppNavigator.of(context).pop(),
        ),
        actions: [
          AppBoxedButton(
            width: 60,
            onPressed: notProvider.count > 0
                ? notProvider.markNotificationsAsRead
                : () {
                    showInfoNotification('No unread notifications');
                  },
            icon: LocalSvgImage(notificationCheckSvg),
          ),
          const XBox(Insets.dim_16),
        ],
        bottom: notProvider.readNotificationRes.isLoading ||
                notProvider.notificationRes.isLoading
            ? const PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: AppLinearLoadingWidget(),
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.dim_16),
        child: ListView(
          children: [
            if (notProvider.notificationRes.isSuccess)
              ...List.generate(
                notProvider.notificationRes.data!.length,
                (index) {
                  final data = notProvider.notificationRes.data![index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: Insets.dim_12),
                    child: AppListTileWidget(
                      args: ListTileWidgetArgs(
                        title: data.type.replaceAll('_', ' ').capitalize(),
                        subtitle: Text(
                          data.body,
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: data.isRead
                                ? AppColors.black
                                : AppColors.textBodyColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            letterSpacing: 0.30,
                          ),
                        ),
                        tileColor: data.isRead
                            ? AppColors.white
                            : AppColors.appGreen.withOpacity(0.1),
                        trailing: Text(
                          DateUtil.covertStringToDate(data.createdAt)
                              .timeAgo()
                              .capitalize(),
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: data.isRead
                                ? AppColors.black.withOpacity(0.5)
                                : AppColors.textHeaderColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.30,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
