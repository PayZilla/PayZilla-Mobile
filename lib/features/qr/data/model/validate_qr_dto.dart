import 'package:equatable/equatable.dart';

enum WalletType { none, wallet }

class ValidateQRDto extends Equatable {
  const ValidateQRDto({
    required this.channel,
    required this.walletChannel,
  });

  factory ValidateQRDto.empty() => ValidateQRDto(
        channel: WalletType.none,
        walletChannel: WalletChannel.empty(),
      );

  final WalletType channel;
  final WalletChannel walletChannel;

  ValidateQRDto copyWith({
    WalletType? walletType,
    WalletChannel? walletChannel,
  }) {
    return ValidateQRDto(
      channel: walletType ?? WalletType.none,
      walletChannel: walletChannel ?? this.walletChannel,
    );
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['channel'] = channel.name;
    data['wallet_channel'] = walletChannel.toMap();
    return data;
  }

  @override
  List<Object?> get props => [
        channel,
        walletChannel,
      ];
}

class WalletChannel extends Equatable {
  const WalletChannel({
    required this.paymentId,
  });

  factory WalletChannel.empty() => const WalletChannel(paymentId: '');

  final String paymentId;

  WalletChannel copyWith({
    String? paymentId,
  }) {
    return WalletChannel(
      paymentId: paymentId ?? this.paymentId,
    );
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['payment_id'] = paymentId;
    return data;
  }

  @override
  List<Object> get props => [paymentId];
}
