import 'package:equatable/equatable.dart';

enum Channel { none, bank, wallet }

class ValidateBankOrWalletDto extends Equatable {
  const ValidateBankOrWalletDto({
    required this.channel,
    required this.bankChannel,
    required this.walletChannel,
    required this.description,
    required this.transactionPin,
    required this.amount,
  });

  factory ValidateBankOrWalletDto.empty() => ValidateBankOrWalletDto(
        channel: Channel.none,
        description: '',
        transactionPin: '',
        amount: 0,
        bankChannel: BankChannel.empty(),
        walletChannel: WalletChannel.empty(),
      );

  ValidateBankOrWalletDto copyWith({
    Channel? channel,
    BankChannel? bankChannel,
    WalletChannel? walletChannel,
    String? description,
    String? transactionPin,
    int? amount,
  }) {
    return ValidateBankOrWalletDto(
      channel: channel ?? this.channel,
      bankChannel: bankChannel ?? this.bankChannel,
      walletChannel: walletChannel ?? this.walletChannel,
      description: description ?? this.description,
      transactionPin: transactionPin ?? this.transactionPin,
      amount: amount ?? this.amount,
    );
  }

  final Channel channel;
  final String description;
  final String transactionPin;
  final int amount;
  final BankChannel bankChannel;
  final WalletChannel walletChannel;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['channel'] = channel.name;
    if (description.isNotEmpty) {
      data['description'] = description;
    }
    if (transactionPin.isNotEmpty) {
      data['transaction_pin'] = transactionPin;
    }
    if (amount > 0) {
      data['amount'] = amount * 100;
    }
    if (bankChannel != BankChannel.empty()) {
      data['bank_channel'] = bankChannel.toJson();
    }
    if (walletChannel != WalletChannel.empty()) {
      data['wallet_channel'] = walletChannel.toJson();
    }
    return data;
  }

  @override
  List<Object?> get props => [channel, bankChannel, walletChannel];
}

class BankChannel extends Equatable {
  const BankChannel({
    required this.bankCode,
    required this.accountNumber,
  });

  factory BankChannel.empty() => const BankChannel(
        bankCode: '',
        accountNumber: '',
      );

  final String bankCode;
  final String accountNumber;
  BankChannel copyWith({
    String? bankCode,
    String? accountNumber,
  }) {
    return BankChannel(
      bankCode: bankCode ?? this.bankCode,
      accountNumber: accountNumber ?? this.accountNumber,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bank_code'] = bankCode;
    data['account_number'] = accountNumber;
    return data;
  }

  @override
  List<Object?> get props => [bankCode, accountNumber];
}

class WalletChannel extends Equatable {
  const WalletChannel({required this.paymentId});

  factory WalletChannel.fromJson(Map<String, dynamic> json) {
    return WalletChannel(
      paymentId: json['payment_id'] ?? '',
    );
  }
  factory WalletChannel.empty() => const WalletChannel(paymentId: '');

  final String paymentId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['payment_id'] = paymentId;
    return data;
  }

  WalletChannel copyWith({
    String? paymentId,
  }) {
    return WalletChannel(
      paymentId: paymentId ?? this.paymentId,
    );
  }

  @override
  List<Object?> get props => [paymentId];
}
