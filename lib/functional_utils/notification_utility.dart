import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';

enum NotificationMessageType { info, error, success }

// for info messages
void showInfoNotification(
  BuildContext context,
  String message, {
  int? durationInMills,
  bool autoDismiss = true,
}) {
  _showNotification(
    context,
    message,
    NotificationMessageType.info,
    durationInMills: durationInMills,
    autoDismiss: autoDismiss,
  );
}

// for error messages
void showErrorNotification(
  BuildContext context,
  String message, {
  int? durationInMills,
  bool autoDismiss = true,
}) {
  if (message == 'Phone number must be verified') {
    const SizedBox.shrink();
  } else {
    _showNotification(
      context,
      message,
      message == 'Phone number must be verified'
          ? NotificationMessageType.info
          : NotificationMessageType.error,
      durationInMills: durationInMills,
      autoDismiss: autoDismiss,
    );
  }
}

// for success messages
void showSuccessNotification(
  BuildContext context,
  String message, {
  int? durationInMills,
  bool autoDismiss = true,
}) {
  _showNotification(
    context,
    message,
    NotificationMessageType.success,
    durationInMills: durationInMills,
    autoDismiss: autoDismiss,
  );
}

void _showNotification(
  BuildContext context,
  String message,
  NotificationMessageType type, {
  int? durationInMills,
  bool autoDismiss = true,
}) {
  Flushbar(
    message: message,
    duration: Duration(milliseconds: durationInMills ?? 3000),
    flushbarPosition: FlushbarPosition.TOP,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.elasticInOut,
    animationDuration: const Duration(milliseconds: 500),
    backgroundColor: type == NotificationMessageType.error
        ? AppColors.borderErrorColor
        : type == NotificationMessageType.info
            ? AppColors.textHeaderColor
            : AppColors.btnPrimaryColor,
    titleText: Text(
      type == NotificationMessageType.error
          ? 'Error'
          : type == NotificationMessageType.info
              ? 'Info'
              : 'Success',
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    icon: Icon(
      type == NotificationMessageType.error
          ? Icons.error
          : type == NotificationMessageType.info
              ? Icons.info
              : Icons.check_circle,
      color: type == NotificationMessageType.error
          ? Colors.white
          : type == NotificationMessageType.info
              ? AppColors.white
              : AppColors.btnPrimaryColor,
    ),
    // messageText: Text(message, style: TextStyle(color: Colors.white),),
  ).show(context);
}
