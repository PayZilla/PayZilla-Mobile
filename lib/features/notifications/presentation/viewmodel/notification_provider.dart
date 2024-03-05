import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/mixins/use_case.dart';
import 'package:pay_zilla/features/notifications/notifications.dart';
import 'package:pay_zilla/features/notifications/usecase/notification_usecase.dart';

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
