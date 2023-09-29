import 'package:equatable/equatable.dart';

class WalletOrBankModel extends Equatable {
  const WalletOrBankModel({
    required this.name,
    required this.accountNumber,
    required this.bankCode,
    required this.bankName,
    required this.avatarUrl,
  });
  factory WalletOrBankModel.fromJson(Map<String, dynamic> json) {
    return WalletOrBankModel(
      name: json['name'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
      bankCode: json['bankCode'] ?? '',
      bankName: json['bankName'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
    );
  }

  factory WalletOrBankModel.empty() {
    return const WalletOrBankModel(
      name: '',
      accountNumber: '',
      bankCode: '',
      bankName: '',
      avatarUrl: '',
    );
  }

  final String name;
  final String accountNumber;
  final String bankCode;
  final String bankName;
  final String avatarUrl;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['accountNumber'] = accountNumber;
    data['bankCode'] = bankCode;
    data['bankName'] = bankName;
    data['avatarUrl'] = avatarUrl;
    return data;
  }

  @override
  List<Object?> get props =>
      [name, accountNumber, bankCode, bankName, avatarUrl];
}
