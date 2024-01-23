import 'package:equatable/equatable.dart';

class TransactionData extends Equatable {
  const TransactionData({
    required this.perPage,
    required this.totalCount,
    required this.transactions,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      perPage: json['perPage'] ?? 0,
      totalCount: json['totalCount'] ?? 0,
      transactions: (json['transactions'] as List)
          .map((e) => TransactionModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
  final int perPage;
  final int totalCount;
  final List<TransactionModel> transactions;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['perPage'] = perPage;
    data['totalCount'] = totalCount;
    data['transactions'] = transactions.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  List<Object?> get props => [perPage, totalCount, transactions];
}

class TransactionModel extends Equatable {
  const TransactionModel({
    required this.reference,
    required this.category,
    required this.type,
    required this.status,
    required this.amount,
    required this.description,
    required this.date,
  });
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      reference: json['reference'] ?? '',
      category: json['category'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      amount: json['amount'] ?? 0.0,
      description: json['description'] ?? '',
      date: json['date'] ?? '',
    );
  }

  factory TransactionModel.empty() {
    return const TransactionModel(
      reference: '',
      category: '',
      type: '',
      status: '',
      amount: 0.0,
      description: '',
      date: '',
    );
  }

  final String reference;
  final String category;
  final String type;
  final String status;
  final num amount;
  final String description;
  final String date;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['reference'] = reference;
    data['category'] = category;
    data['type'] = type;
    data['status'] = status;
    data['amount'] = amount;
    data['description'] = description;
    data['date'] = date;
    return data;
  }

  @override
  List<Object?> get props =>
      [reference, category, type, status, amount, description, date];
}
