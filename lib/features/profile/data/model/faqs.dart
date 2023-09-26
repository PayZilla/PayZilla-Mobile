import 'package:equatable/equatable.dart';

class FAQsModel extends Equatable {
  const FAQsModel({required this.title, required this.body});

  factory FAQsModel.fromJson(Map<String, dynamic> json) {
    return FAQsModel(
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }
  final String title;
  final String body;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;
    return data;
  }

  @override
  List<Object?> get props => [title, body];
}
