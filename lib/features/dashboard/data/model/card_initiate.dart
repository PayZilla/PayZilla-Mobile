import 'package:equatable/equatable.dart';

class CardInitiateModel extends Equatable {
  const CardInitiateModel({
    required this.referenceId,
    required this.url,
    required this.accessCode,
  });

  factory CardInitiateModel.fromJson(Map<String, dynamic> json) {
    return CardInitiateModel(
      referenceId: json['referenceId'] ?? '',
      url: json['url'] ?? '',
      accessCode: json['accessCode'] ?? '',
    );
  }
  final String referenceId;
  final String url;
  final String accessCode;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['referenceId'] = referenceId;
    data['url'] = url;
    data['accessCode'] = accessCode;
    return data;
  }

  @override
  List<Object?> get props => [referenceId, url, accessCode];
}
