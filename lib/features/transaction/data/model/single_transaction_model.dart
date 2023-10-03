import 'package:equatable/equatable.dart';

class SingleTransactionModel extends Equatable {
  const SingleTransactionModel({
    required this.reference,
    required this.category,
    required this.type,
    required this.status,
    required this.amount,
    required this.description,
    required this.date,
    required this.meta,
  });
  factory SingleTransactionModel.fromJson(Map<String, dynamic> json) {
    return SingleTransactionModel(
      reference: json['reference'] ?? '',
      category: json['category'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      amount: json['amount'] ?? 0,
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      meta: (json['meta'] as List)
          .map((i) => Meta.fromJson(Map<String, dynamic>.from(i)))
          .toList(),
    );
  }

  factory SingleTransactionModel.empty() {
    return const SingleTransactionModel(
      reference: '',
      category: '',
      type: '',
      status: '',
      amount: 0,
      description: '',
      date: '',
      meta: [],
    );
  }

  bool get isEmpty => this == SingleTransactionModel.empty();

  final String reference;
  final String category;
  final String type;
  final String status;
  final int amount;
  final String description;
  final String date;
  final List<Meta> meta;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['reference'] = reference;
    data['category'] = category;
    data['type'] = type;
    data['status'] = status;
    data['amount'] = amount;
    data['description'] = description;
    data['date'] = date;
    data['meta'] = meta.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  List<Object?> get props =>
      [reference, category, type, status, amount, description, date, meta];
}

class Meta extends Equatable {
  const Meta({
    required this.key,
    required this.val,
  });
  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      key: json['key'] ?? '',
      val: json['val'] ?? '',
    );
  }

  final String key;
  final String val;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['key'] = key;
    data['val'] = val;
    return data;
  }

  @override
  List<Object?> get props => [key, val];
}
