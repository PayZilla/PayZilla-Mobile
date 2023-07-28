import 'package:flutter/material.dart';
import 'package:pay_zilla/functional_utils/assets.dart';

class NotificationProvider extends ChangeNotifier {
  final notificationList = [
    NotificationAsset(
      asset: rewardSvg,
      title: 'Reward',
      subtitle: 'Loyal user rewards!😘',
      time: '1m ago',
    ),
    NotificationAsset(
      asset: withdrawSvg,
      title: 'Money Transfer',
      subtitle: 'You have successfully sent money to Maria of...',
      time: '25m ago',
    ),
    NotificationAsset(
      asset: paymentSvg,
      title: 'Payment Notification',
      subtitle: 'Successfully paid!🤑',
      time: 'Mar 20',
    ),
    NotificationAsset(
      asset: depositSvg,
      title: 'Top Up',
      subtitle: 'Your top up is successfully!',
      time: 'Mar 13',
    ),
    NotificationAsset(
      asset: withdrawSvg,
      title: 'Money Transfer',
      subtitle: 'You have successfully sent money to Maria of...',
      time: 'Mar 13',
    ),
    NotificationAsset(
      asset: cashbackSvg,
      title: 'Cashback 25%',
      subtitle: 'You have successfully sent money to Maria of...',
      time: 'Mar 20',
    ),
    NotificationAsset(
      asset: paymentSvg,
      title: 'Payment Notification',
      subtitle: 'Successfully paid!🤑',
      time: 'Mar 20',
    ),
  ];
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
