import 'dart:convert';

import 'package:equatable/equatable.dart';

class ResponseDto extends Equatable {
  const ResponseDto({
    required this.message,
    required this.statusCode,
    required this.status,
    required this.data,
    required this.errors,
  });

  factory ResponseDto.fromMap(Map<String, dynamic> map) {
    return ResponseDto(
      message: map['message'] ?? '',
      statusCode: map['statusCode'] ?? 0,
      status: map['status'] ?? false,
      data: map['data'],
      errors: map['errors'],
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'statusCode': statusCode,
        'status': status,
        'data': data,
        'errors': errors,
      };
  String toMap() => json.encode(toJson());

  final bool status;
  final String message;
  final int statusCode;
  final dynamic data;
  final dynamic errors;

  bool get isResultOk =>
      status ||
      statusCode <=
          204; //NOTE: this validates that all response from server is OK

  @override
  List<Object> get props => [message, statusCode, data, errors];
}
