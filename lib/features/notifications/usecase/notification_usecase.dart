import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/core/mixins/use_case.dart';
import 'package:pay_zilla/features/notifications/notifications.dart';

class GetNotificationUseCase implements UseCase<NotificationModel, String> {
  GetNotificationUseCase({required this.notificationRepository});
  NotificationRepository notificationRepository;

  @override
  Future<Either<ApiFailure, NotificationModel>> call(String params) {
    return notificationRepository.getNotification(params);
  }
}

class GetNotificationsUseCase
    implements UseCase<List<NotificationModel>, NoParams> {
  GetNotificationsUseCase({required this.notificationRepository});
  NotificationRepository notificationRepository;

  @override
  Future<Either<ApiFailure, List<NotificationModel>>> call(NoParams params) {
    return notificationRepository.getNotifications();
  }
}

class MarkNotificationUseCase implements UseCase<String, String> {
  MarkNotificationUseCase({required this.notificationRepository});
  NotificationRepository notificationRepository;

  @override
  Future<Either<ApiFailure, String>> call(String params) {
    return notificationRepository.markNotificationAsRead(params);
  }
}

class MarkNotificationsUseCase implements UseCase<String, NoParams> {
  MarkNotificationsUseCase({required this.notificationRepository});
  NotificationRepository notificationRepository;

  @override
  Future<Either<ApiFailure, String>> call(NoParams params) {
    return notificationRepository.markNotificationsAsRead();
  }
}
