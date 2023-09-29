import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/notifications/notifications.dart';

class NotificationRepository extends Repository {
  NotificationRepository(this.remoteDataSource);

  final INotificationDataSource remoteDataSource;

  Future<Either<Failure, NotificationModel>> getNotification(String id) async {
    return runGuard(() async {
      final response = await remoteDataSource.getNotification(id);

      return response;
    });
  }

  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    return runGuard(() async {
      final response = await remoteDataSource.getNotifications();

      return response;
    });
  }

  Future<Either<Failure, String>> markNotificationAsRead(String id) async {
    return runGuard(() async {
      final response = await remoteDataSource.markNotificationAsRead(id);

      return response;
    });
  }

  Future<Either<Failure, String>> markNotificationsAsRead() async {
    return runGuard(() async {
      final response = await remoteDataSource.markNotificationsAsRead();

      return response;
    });
  }
}
