import 'package:equatable/equatable.dart';

class ContactsModel extends Equatable {
  const ContactsModel({
    required this.name,
    required this.paymentId,
    required this.avatar,
  });

  factory ContactsModel.fromJson(Map<String, dynamic> json) {
    return ContactsModel(
      name: json['name'] ?? '',
      paymentId: json['payment_id'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
  final String name;
  final String paymentId;
  final String avatar;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['payment_id'] = paymentId;
    data['avatar'] = avatar;
    return data;
  }

  @override
  List<Object?> get props => [name, paymentId, avatar];
}
