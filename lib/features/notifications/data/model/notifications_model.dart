import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  const NotificationModel({
    required this.uuid,
    required this.type,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      uuid: json['uuid'] ?? '',
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      isRead: json['is_read'] ?? false,
      createdAt: json['created_at'] ?? '',
    );
  }
  factory NotificationModel.empty() {
    return const NotificationModel(
      uuid: '',
      type: '',
      title: '',
      body: '',
      isRead: false,
      createdAt: '',
    );
  }

  final String uuid;
  final String type;
  final String title;
  final String body;
  final bool isRead;
  final String createdAt;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['type'] = type;
    data['title'] = title;
    data['body'] = body;
    data['is_read'] = isRead;
    data['created_at'] = createdAt;

    return data;
  }

  @override
  List<Object?> get props => [uuid, type, title, body, isRead, createdAt];
}
