import 'dart:convert';

import 'package:equatable/equatable.dart';

class SendMoneyModel extends Equatable {
  const SendMoneyModel({
    required this.sendAmount,
    required this.receiveAmount,
    required this.sendCurrencyCode,
    required this.receiveCurrencyCode,
    required this.bankName,
    required this.bankCode,
    required this.accountName,
    required this.accountNumber,
    required this.senderEmailAddress,
    required this.dateCreated,
    required this.status,
    required this.comment,
    required this.id,
    required this.purpose,
    required this.transactionReference,
    required this.narration,
    required this.securityQuestion,
    required this.securityAnswer,
    required this.recipientEmailAddress,
    required this.beneficiaryId,
    required this.recipientIDType,
    required this.recipientIDNumber,
    required this.recipientStreet,
    required this.swiftCode,
    required this.bankBranchCode,
    required this.errorMessage,
    required this.recipientCountryCode,
    required this.recipientPostalCode,
    required this.recipientCity,
    required this.recipientPhoneNumber,
    required this.mobileMoneyProvider,
  });

  factory SendMoneyModel.fromMap(String source) =>
      SendMoneyModel.fromJson(json.decode(source));

  factory SendMoneyModel.fromJson(Map<String, dynamic> json) => SendMoneyModel(
        errorMessage: json['errorMessage'] ?? '',
        sendAmount: json['sendAmount'] ?? 0.0,
        receiveAmount: json['receiveAmount'] ?? 0.0,
        sendCurrencyCode: json['sendCurrencyCode'] ?? '',
        receiveCurrencyCode: json['receiveCurrencyCode'] ?? '',
        bankName: json['bankName'] ?? '',
        securityQuestion: json['securityQuestion'] ?? '',
        securityAnswer: json['securityAnswer'] ?? '',
        bankCode: json['bankCode'] ?? '',
        accountName: json['accountName'] ?? '',
        accountNumber: json['accountNumber'] ?? '',
        senderEmailAddress: json['senderEmailAddress'] ?? '',
        recipientEmailAddress: json['recipientEmailAddress'] ?? '',
        narration: json['narration'] ?? '',
        comment: json['comment'] ?? '',
        purpose: json['purpose'] ?? '',
        id: json['id'] ?? 0,
        transactionReference: json['transactionReference'] ?? '',
        dateCreated: json['dateCreated'] ?? '',
        status: json['status'] ?? 0,
        beneficiaryId: json['beneficiaryId'] ?? '',
        recipientIDType: json['recipientIDType'] ?? '',
        recipientIDNumber: json['recipientIDNumber'] ?? '',
        recipientStreet: json['recipientStreet'] ?? '',
        swiftCode: json['swiftCode'] ?? '',
        bankBranchCode: json['bankBranchCode'] ?? '',
        recipientCountryCode: json['recipientCountryCode'] ?? '',
        recipientPostalCode: json['recipientPostalCode'] ?? '',
        recipientCity: json['recipientCity'] ?? '',
        recipientPhoneNumber: json['recipientPhoneNumber'] ?? '',
        mobileMoneyProvider: json['mobileMoneyProvider'] ?? '',
      );

  factory SendMoneyModel.empty() => const SendMoneyModel(
        sendAmount: 0,
        receiveAmount: 0,
        sendCurrencyCode: '',
        receiveCurrencyCode: '',
        bankName: '',
        bankCode: 0,
        accountName: '',
        accountNumber: 0,
        senderEmailAddress: '',
        dateCreated: '',
        status: 0,
        comment: '',
        id: 0,
        purpose: '',
        transactionReference: '',
        narration: '',
        securityQuestion: '',
        securityAnswer: '',
        recipientEmailAddress: '',
        beneficiaryId: 0,
        recipientIDType: '',
        recipientIDNumber: '',
        recipientStreet: '',
        swiftCode: '',
        bankBranchCode: '',
        errorMessage: '',
        recipientCountryCode: '',
        recipientPostalCode: '',
        recipientCity: '',
        recipientPhoneNumber: '',
        mobileMoneyProvider: '',
      );

  final dynamic sendAmount;
  final dynamic receiveAmount;
  final dynamic sendCurrencyCode;
  final dynamic receiveCurrencyCode;
  final dynamic bankName;
  final dynamic securityQuestion;
  final dynamic securityAnswer;
  final dynamic bankCode;
  final dynamic accountName;
  final dynamic accountNumber;
  final dynamic senderEmailAddress;
  final dynamic recipientEmailAddress;
  final dynamic narration;
  final dynamic id;
  final dynamic purpose;
  final dynamic comment;
  final dynamic transactionReference;
  final String? dateCreated;
  final dynamic status;
  final dynamic beneficiaryId;
  final String? recipientIDType;
  final String? recipientIDNumber;
  final String? recipientStreet;
  final String? swiftCode;
  final String? bankBranchCode;
  final String? errorMessage;
  final String? recipientCountryCode;
  final String? recipientPostalCode;
  final String? recipientCity;
  final String? recipientPhoneNumber;
  final String? mobileMoneyProvider;
  bool get isEmpty => this == SendMoneyModel.empty();

  Map<String, dynamic> toJson() => {
        'sendAmount': sendAmount,
        'receiveAmount': receiveAmount,
        'sendCurrencyCode': sendCurrencyCode,
        'receiveCurrencyCode': receiveCurrencyCode,
        'bankName': bankName,
        'securityQuestion': securityQuestion,
        'securityAnswer': securityAnswer,
        'bankCode': bankCode,
        'accountName': accountName,
        'accountNumber': accountNumber,
        'senderEmailAddress': senderEmailAddress,
        'recipientEmailAddress': recipientEmailAddress,
        'narration': narration,
        'comment': comment,
        'purpose': purpose,
        'id': id,
        'transactionReference': transactionReference,
        'dateCreated': dateCreated,
        'status': status,
        'beneficiaryId': beneficiaryId ?? '',
        'recipientIDType': recipientIDType,
        'recipientIDNumber': recipientIDNumber,
        'recipientStreet': recipientStreet,
        'swiftCode': swiftCode,
        'bankBranchCode': bankBranchCode,
        'errorMessage': errorMessage,
        'recipientCountryCode': recipientCountryCode,
        'recipientPostalCode': recipientPostalCode,
        'recipientCity': recipientCity,
        'recipientPhoneNumber': recipientPhoneNumber,
        'mobileMoneyProvider': mobileMoneyProvider,
      };
  String toMap() => json.encode(toJson());

  @override
  List<Object?> get props => [
        sendAmount,
        receiveAmount,
        sendCurrencyCode,
        receiveCurrencyCode,
        bankName,
        bankCode,
        accountName,
        accountNumber,
        senderEmailAddress,
        dateCreated,
        status,
        comment,
        id,
        purpose,
        transactionReference,
        narration,
        securityQuestion,
        securityAnswer,
        recipientEmailAddress,
        beneficiaryId,
        recipientIDType,
        recipientIDNumber,
        recipientStreet,
        swiftCode,
        bankBranchCode,
        errorMessage,
        recipientCountryCode,
        recipientPostalCode,
        recipientCity,
        recipientPhoneNumber,
        mobileMoneyProvider,
      ];
}
