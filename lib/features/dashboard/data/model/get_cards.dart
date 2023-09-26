import 'package:equatable/equatable.dart';

class CardsModel extends Equatable {
  const CardsModel({
    required this.id,
    required this.last4,
    required this.bin,
    required this.expMonth,
    required this.expYear,
    required this.cardType,
    required this.accountName,
    required this.bank,
  });

  factory CardsModel.fromJson(Map<String, dynamic> json) {
    return CardsModel(
      id: json['id'] ?? '',
      last4: json['last4'] ?? '',
      bin: json['bin'] ?? '',
      expMonth: json['expMonth'] ?? '',
      expYear: json['expYear'] ?? '',
      cardType: json['cardType'] ?? '',
      accountName: json['accountName'] ?? '',
      bank: json['bank'] ?? '',
    );
  }
  final String id;
  final String last4;
  final String bin;
  final String expMonth;
  final String expYear;
  final String cardType;
  final String accountName;
  final String bank;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['last4'] = last4;
    data['bin'] = bin;
    data['expMonth'] = expMonth;
    data['expYear'] = expYear;
    data['cardType'] = cardType;
    data['accountName'] = accountName;
    data['bank'] = bank;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        last4,
        bin,
        expMonth,
        expYear,
        cardType,
        accountName,
        bank,
      ];
}
