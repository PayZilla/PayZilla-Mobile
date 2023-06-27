import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/di/dependency_injection_container.dart';

Future<void> backgroundHandler(RemoteMessage message) async {}

class NotificationManager {
  NotificationManager(
    this.firebaseMessaging,
    this.flutterLocalNotificationsPlugin,
  ) {
    initializeNotificationManager();
  }
  final FirebaseMessaging firebaseMessaging;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static NotificationManager get instance => sl<NotificationManager>();

  /// firebase cloud messenger token for this device
  String fcmToken = '';
  final List<RemoteMessage> _queue = [];

  final StreamController<RemoteMessage> _notification =
      StreamController.broadcast();
  Stream<RemoteMessage> get notification => _notification.stream;

  final AndroidNotificationChannel androidChannel =
      const AndroidNotificationChannel(
    'PZillaichange',
    'PZillaichange',
    description: 'This channel is used for PZillaichange notifications.',
    importance: Importance.max,
  );

  /// this is only required on iOS
  Future<void> requestPermission() async {
    await firebaseMessaging.requestPermission();
  }

  Future initializeNotificationManager() async {
    fcmToken = await firebaseMessaging
        .getToken()
        .then(
          (value) => value ?? '',
        )
        .catchError((err) => '');
    if (Platform.isIOS) await requestPermission();
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handlers
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    const initializationSettingsAndroid =
        AndroidInitializationSettings('android12splash');

    const initializationSettingsIOS = IOSInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );
  }

  /// called when a notification is clicked on the notification tray
  /// Adds the notification payload
  void selectNotification(String? payload) {
    for (var i = 0; i < _queue.length; i++) {
      final msg = _queue[i];
      if (msg.messageId == payload) {
        // add the tapped message to our notification stream
        _notification.add(msg);
        // remove the message from the message queue
        _queue.removeAt(i);
        break;
      }
    }
  }

  /// show a remote notification when the app is in foreground state
  void show(RemoteMessage payload) {
    final android = AndroidNotificationDetails(
      androidChannel.id,
      androidChannel.name,
      channelDescription: androidChannel.description,
      importance: Importance.max,
      priority: Priority.max,
      color: AppColors.borderColor,
      styleInformation: BigTextStyleInformation(
        payload.notification?.body ?? '',
      ),
    );
    const ios = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: false,
    );
    final platform = NotificationDetails(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.show(
      payload.hashCode,
      payload.notification?.title ?? '',
      payload.notification?.body ?? '',
      platform,
      payload: payload.messageId,
    );
  }

  /// subscribe this device to a particular topic
  void subscribeToTopic(String topic) =>
      firebaseMessaging.subscribeToTopic(topic);

  /// handles the notification differently instead of adding to the
  /// notification stream, we'd add it to our notification queue and
  /// when tapped we'd add it the notification stream.
  /// listen for foreground notification and use firebase_local_notification
  /// handle displaying it
  Future<void> _onMessageHandler(RemoteMessage message) async {
    _queue.add(message);
    show(message);
  }

  /// handle the initial message if the app was opened from a terminated state via
  /// a notification
  Future<void> getInitialMessage() async {
    final initialMsg = await firebaseMessaging.getInitialMessage();
    if (initialMsg != null) {
      _notification.add(initialMsg);
    }
  }

  /// get the message if the app was opened from a background state via
  /// a notification
  Future<void> _onMessageOpenApp(RemoteMessage message) async {
    _notification.add(message);
  }

  void dispose() {
    _notification.close();
  }
}
