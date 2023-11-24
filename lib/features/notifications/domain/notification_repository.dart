import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/notifications/notifications.dart';

abstract class NotificationRepository {
  Future<Either<ApiFailure, NotificationModel>> getNotification(String id);
  Future<Either<ApiFailure, List<NotificationModel>>> getNotifications();
  Future<Either<ApiFailure, String>> markNotificationAsRead(String id);
  Future<Either<ApiFailure, String>> markNotificationsAsRead();
}

class NotificationRepositoryImpl extends NotificationRepository {
  NotificationRepositoryImpl(this.remoteDataSource);

  final INotificationDataSource remoteDataSource;

  @override
  Future<Either<ApiFailure, NotificationModel>> getNotification(
    String id,
  ) async {
    return remoteDataSource.getNotification(id);
  }

  @override
  Future<Either<ApiFailure, List<NotificationModel>>> getNotifications() async {
    return remoteDataSource.getNotifications();
  }

  @override
  Future<Either<ApiFailure, String>> markNotificationAsRead(String id) async {
    return remoteDataSource.markNotificationAsRead(id);
  }

  @override
  Future<Either<ApiFailure, String>> markNotificationsAsRead() async {
    return remoteDataSource.markNotificationsAsRead();
  }
}
