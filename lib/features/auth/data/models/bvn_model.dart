import 'dart:convert';

import 'package:equatable/equatable.dart';

class BvnModel {
  BvnModel({
    required this.targetFunc,
    required this.data,
    required this.msgId,
  });

  factory BvnModel.empty() => BvnModel(
        targetFunc: '',
        data: BvnData.empty(),
        msgId: '',
      );
  factory BvnModel.fromJson(Map<String, dynamic> json) {
    return BvnModel(
      targetFunc: json['targetFunc'],
      data: BvnData.fromJson(jsonDecode(json['data'])),
      msgId: json['msgId'],
    );
  }
  final String targetFunc;
  final BvnData data;
  final String msgId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['targetFunc'] = targetFunc;
    data['data'] = this.data;
    data['msgId'] = msgId;
    return data;
  }
}

class BvnData extends Equatable {
  const BvnData({
    required this.status,
    required this.bvn,
    required this.bvnPhoneNumber,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.dob,
    required this.code,
    required this.enrollUserName,
  });

  factory BvnData.fromJson(Map<String, dynamic> json) {
    return BvnData(
      status: json['status'] ?? false,
      bvn: json['bvn'] ?? '',
      bvnPhoneNumber: json['bvnPhoneNumber'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      middleName: json['middleName'] ?? '',
      dob: json['dob'] ?? '',
      code: json['code'] ?? '',
      enrollUserName: json['enroll_user_name'] ?? '',
    );
  }

  factory BvnData.empty() => const BvnData(
        status: false,
        bvn: '',
        bvnPhoneNumber: '',
        firstName: '',
        lastName: '',
        middleName: '',
        dob: '',
        code: '',
        enrollUserName: '',
      );

  bool get isEmpty => this == BvnData.empty();

  String get fullName => '$firstName $lastName $middleName';
  final bool status;
  final String bvn;
  final String bvnPhoneNumber;
  final String firstName;
  final String lastName;
  final String middleName;
  final String dob;
  final String code;
  final String enrollUserName;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['bvn'] = bvn;
    data['bvnPhoneNumber'] = bvnPhoneNumber;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['middleName'] = middleName;
    data['dob'] = dob;
    data['code'] = code;
    data['enroll_user_name'] = enrollUserName;
    return data;
  }

  @override
  List<Object?> get props => [
        status,
        bvn,
        bvnPhoneNumber,
        firstName,
        lastName,
        middleName,
        dob,
        code,
        enrollUserName,
      ];
}
