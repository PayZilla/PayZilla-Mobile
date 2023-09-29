import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/notifications/notifications.dart';

abstract class INotificationDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<NotificationModel> getNotification(String id);
  Future<String> markNotificationAsRead(String id);
  Future<String> markNotificationsAsRead();
}

class NotificationDataSource implements INotificationDataSource {
  NotificationDataSource(this.http);

  final HttpManager http;
  @override
  Future<NotificationModel> getNotification(String id) async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(notificationEndpoints.getNotification(id)),
      );
      if (response.isResultOk) {
        return NotificationModel.fromJson(response.data);
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final response = ResponseDto.fromMap(
        await http.get(notificationEndpoints.getNotifications),
      );
      if (response.isResultOk) {
        final data = response.data['notifications'] as List;
        return data
            .map(
              (e) => NotificationModel.fromJson(Map<String, dynamic>.from(e)),
            )
            .toList();
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> markNotificationAsRead(String id) async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          notificationEndpoints.notificationSeen(id),
          {},
        ),
      );
      if (response.isResultOk) {
        return response.message;
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> markNotificationsAsRead() async {
    try {
      final response = ResponseDto.fromMap(
        await http.post(
          notificationEndpoints.notificationsSeen,
          {},
        ),
      );
      if (response.isResultOk) {
        return response.message;
      }
      throw AppServerException(response.message);
    } catch (_) {
      rethrow;
    }
  }
}
