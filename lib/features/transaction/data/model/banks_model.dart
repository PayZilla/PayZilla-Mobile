import 'package:equatable/equatable.dart';

class BanksModel extends Equatable {
  const BanksModel({
    required this.code,
    required this.name,
  });
  factory BanksModel.fromJson(Map<String, dynamic> json) {
    return BanksModel(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
    );
  }
  final String code;
  final String name;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    return data;
  }

  @override
  List<Object?> get props => [code, name];
}
