import 'package:equatable/equatable.dart';

class BillCatModel extends Equatable {
  const BillCatModel({
    required this.identifier,
    required this.name,
    required this.billCodeName,
  });

  factory BillCatModel.fromJson(Map<String, dynamic> json) {
    return BillCatModel(
      identifier: json['identifier'] ?? '',
      name: json['name'] ?? '',
      billCodeName: json['billCodeName'] ?? '',
    );
  }
  final String identifier;
  final String name;
  final String billCodeName;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['name'] = name;
    data['billCodeName'] = billCodeName;
    return data;
  }

  @override
  List<Object?> get props => [identifier, name, billCodeName];
}
