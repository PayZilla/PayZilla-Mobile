import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/mixins/use_case.dart';
import 'package:pay_zilla/features/notifications/notifications.dart';
import 'package:pay_zilla/features/notifications/usecase/notification_usecase.dart';
import 'package:pay_zilla/functional_utils/assets.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider(
    this.getNotificationUseCase,
    this.getNotificationsUseCase,
    this.markNotificationUseCase,
    this.markNotificationsUseCase,
  );

  final GetNotificationUseCase getNotificationUseCase;
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkNotificationUseCase markNotificationUseCase;
  final MarkNotificationsUseCase markNotificationsUseCase;

  ApiResult<List<NotificationModel>> notificationRes =
      ApiResult<List<NotificationModel>>.idle();

  ApiResult<String> readNotificationRes = ApiResult<String>.idle();

  int _count = 0;
  int get count => _count;
  set count(int count) {
    _count = count;
    notifyListeners();
  }

  Future<void> getNotifications() async {
    notificationRes = ApiResult<List<NotificationModel>>.loading('Loading...');
    notifyListeners();
    final failureOrNotification =
        await getNotificationsUseCase.call(NoParams());
    failureOrNotification.fold(
      (failure) {
        notificationRes =
            ApiResult<List<NotificationModel>>.error(failure.message);
        notifyListeners();
      },
      (res) {
        notificationRes = ApiResult<List<NotificationModel>>.success(res);

        for (final notification in res) {
          if (!notification.isRead) {
            count++;
          }
        }
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> markNotificationsAsRead() async {
    readNotificationRes = ApiResult<String>.loading('Loading...');
    notifyListeners();
    final failureOrNotification =
        await markNotificationsUseCase.call(NoParams());
    await failureOrNotification.fold(
      (failure) {
        readNotificationRes = ApiResult<String>.error(failure.message);
        notifyListeners();
      },
      (res) async {
        await getNotifications();
        count = 0;
        readNotificationRes = ApiResult<String>.success(res);
        notifyListeners();
      },
    );
    notifyListeners();
  }

  final notificationList = [
    NotificationAsset(
      asset: rewardSvg,
      title: 'Reward',
      subtitle: 'Loyal user rewards!😘',
      time: '1m ago',
    ),
    NotificationAsset(
      asset: withdrawSvg,
      title: 'Money Transfer',
      subtitle: 'You have successfully sent money to Maria of...',
      time: '25m ago',
    ),
    NotificationAsset(
      asset: paymentSvg,
      title: 'Payment Notification',
      subtitle: 'Successfully paid!🤑',
      time: 'Mar 20',
    ),
    NotificationAsset(
      asset: depositSvg,
      title: 'Top Up',
      subtitle: 'Your top up is successfully!',
      time: 'Mar 13',
    ),
    NotificationAsset(
      asset: withdrawSvg,
      title: 'Money Transfer',
      subtitle: 'You have successfully sent money to Maria of...',
      time: 'Mar 13',
    ),
    NotificationAsset(
      asset: cashbackSvg,
      title: 'Cashback 25%',
      subtitle: 'You have successfully sent money to Maria of...',
      time: 'Mar 20',
    ),
    NotificationAsset(
      asset: paymentSvg,
      title: 'Payment Notification',
      subtitle: 'Successfully paid!🤑',
      time: 'Mar 20',
    ),
  ];
}

class NotificationAsset {
  NotificationAsset({
    required this.asset,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  final String asset;
  final String title;
  final String subtitle;
  final String time;
}
