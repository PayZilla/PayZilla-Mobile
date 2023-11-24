import 'package:dartz/dartz.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/notifications/notifications.dart';

abstract class INotificationDataSource {
  Future<Either<ApiFailure, NotificationModel>> getNotification(String id);

  Future<Either<ApiFailure, List<NotificationModel>>> getNotifications();
  Future<Either<ApiFailure, String>> markNotificationAsRead(String id);
  Future<Either<ApiFailure, String>> markNotificationsAsRead();
}

class NotificationDataSource implements INotificationDataSource {
  NotificationDataSource(this.http);

  final HttpManager http;
  @override
  Future<Either<ApiFailure, NotificationModel>> getNotification(
      String id) async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(notificationEndpoints.getNotification(id)),
      );

      return Right(NotificationModel.fromJson(response.data));
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, List<NotificationModel>>> getNotifications() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(notificationEndpoints.getNotifications),
      );

      return Right(
        (response.data['notifications'] as List)
            .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, String>> markNotificationAsRead(String id) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          notificationEndpoints.notificationSeen(id),
          {},
        ),
      );
      return Right(response.message);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, String>> markNotificationsAsRead() async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          notificationEndpoints.notificationsSeen,
          {},
        ),
      );
      return Right(response.message);
    } on AppServerException catch (err) {
      return Left(ApiFailure(msg: err.message));
    } catch (err) {
      return Left(ApiFailure(msg: err.toString()));
    }
  }
}
