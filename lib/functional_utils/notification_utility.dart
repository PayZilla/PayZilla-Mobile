import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

enum NotificationMessageType { info, error, success }

// for info messages
void showInfoNotification(
  String message, {
  int? durationInMills,
  bool autoDismiss = true,
}) {
  _showNotification(
    message,
    NotificationMessageType.info,
    durationInMills: durationInMills,
    autoDismiss: autoDismiss,
  );
}

// for error messages
void showErrorNotification(
  String message, {
  int? durationInMills,
  bool autoDismiss = true,
}) {
  _showNotification(
    message,
    NotificationMessageType.error,
    durationInMills: durationInMills,
    autoDismiss: autoDismiss,
  );
}

// for success messages
void showSuccessNotification(
  String message, {
  int? durationInMills,
  bool autoDismiss = true,
}) {
  _showNotification(
    message,
    NotificationMessageType.success,
    durationInMills: durationInMills,
    autoDismiss: autoDismiss,
  );
}

// generic notification method
void _showNotification(
  String message,
  NotificationMessageType type, {
  int? durationInMills,
  bool autoDismiss = true,
}) {
  showSimpleNotification(
    Column(
      children: [
        Row(
          children: [
            Icon(
              _getNotificationItemFromType(type).iconData,
              color: const Color(0xFFFFFFFF),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getNotificationItemFromType(type).title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    ),
    background: _getNotificationItemFromType(type).itemColor,
    slideDismissDirection: DismissDirection.up,
    elevation: 5,
    duration: Duration(milliseconds: durationInMills ?? 700),
    autoDismiss: autoDismiss,
  );
}

// get notification item from the type supplied
_NotificationItem _getNotificationItemFromType(NotificationMessageType type) {
  switch (type) {
    case NotificationMessageType.error:
      return _NotificationItem(
        title: 'Error',
        iconData: Icons.error_outline_rounded,
        itemColor: Colors.red,
      );
    case NotificationMessageType.info:
      return _NotificationItem(
        title: 'Info',
        iconData: Icons.info_outline_rounded,
        itemColor: Colors.grey.shade800,
      );
    case NotificationMessageType.success:
      return _NotificationItem(
        title: 'Success',
        iconData: Icons.check_circle_outline_rounded,
        itemColor: const Color(0xff7165E3),
      );
  }
}

class _NotificationItem {
  _NotificationItem({
    required this.title,
    required this.iconData,
    required this.itemColor,
  });

  final String title;
  final IconData iconData;
  final Color itemColor;
}
