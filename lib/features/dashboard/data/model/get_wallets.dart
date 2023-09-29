import 'package:equatable/equatable.dart';

class WalletsModel extends Equatable {
  const WalletsModel({
    required this.currency,
    required this.balance,
  });

  factory WalletsModel.fromJson(Map<String, dynamic> json) {
    return WalletsModel(
      currency: json['currency'] ?? '',
      balance: json['balance'] ?? '0',
    );
  }
  final String currency;
  final String balance;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['currency'] = currency;
    data['balance'] = balance;
    return data;
  }

  @override
  List<Object?> get props => [currency, balance];
}
