import 'package:equatable/equatable.dart';

class AccountDetailsModel extends Equatable {
  const AccountDetailsModel({
    required this.name,
    required this.paymentId,
    required this.hasSetPin,
    required this.banks,
  });

  factory AccountDetailsModel.fromJson(Map<String, dynamic> json) {
    return AccountDetailsModel(
      name: json['name'] ?? '',
      paymentId: json['payment_id'] ?? '',
      hasSetPin: json['has_set_pin'] ?? '',
      banks: (json['banks'] as List).map((i) => Banks.fromJson(i)).toList(),
    );
  }
  final String name;
  final String paymentId;
  final bool hasSetPin;
  final List<Banks> banks;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['payment_id'] = paymentId;
    data['has_set_pin'] = hasSetPin;
    data['banks'] = banks.map((v) => v.toJson()).toList();

    return data;
  }

  @override
  List<Object?> get props => [name, paymentId, hasSetPin, banks];
}

class Banks extends Equatable {
  const Banks({
    required this.bankName,
    required this.accountNumber,
  });

  factory Banks.fromJson(Map<String, dynamic> json) {
    return Banks(
      bankName: json['bank_name'] ?? '',
      accountNumber: json['account_number'] ?? '',
    );
  }
  final String bankName;
  final String accountNumber;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bank_name'] = bankName;
    data['account_number'] = accountNumber;
    return data;
  }

  @override
  List<Object?> get props => [bankName, accountNumber];
}
