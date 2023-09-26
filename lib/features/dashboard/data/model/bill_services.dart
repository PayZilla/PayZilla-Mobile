import 'package:equatable/equatable.dart';

class BillServiceModel extends Equatable {
  const BillServiceModel({
    required this.serviceId,
    required this.name,
  });

  factory BillServiceModel.fromJson(Map<String, dynamic> json) {
    return BillServiceModel(
      serviceId: json['serviceId'] ?? '',
      name: json['name'] ?? '',
    );
  }
  final String serviceId;
  final String name;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['serviceId'] = serviceId;
    data['name'] = name;
    return data;
  }

  @override
  List<Object?> get props => [serviceId, name];
}
