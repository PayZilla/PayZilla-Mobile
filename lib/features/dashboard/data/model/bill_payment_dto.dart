import 'package:equatable/equatable.dart';

class BillPaymentDto extends Equatable {
  const BillPaymentDto({
    required this.amount,
    required this.phoneNumber,
    required this.pin,
    required this.customerId,
    required this.serviceId,
    required this.variationCode,
    required this.varianceCode,
    required this.billName,
  });

  factory BillPaymentDto.empty() {
    return const BillPaymentDto(
      amount: 0,
      phoneNumber: '',
      pin: '',
      customerId: '',
      serviceId: '',
      variationCode: '',
      varianceCode: '',
      billName: '',
    );
  }

  final int amount;
  final String phoneNumber;
  final String pin;
  final String customerId;
  final String serviceId;
  final String variationCode;
  final String varianceCode;
  final String billName;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (amount > 0) {
      data['amount'] = amount;
    }
    if (pin.isNotEmpty) {
      data['transaction_pin'] = pin;
    }
    if (phoneNumber.isNotEmpty) {
      data['beneficiary_phone'] = phoneNumber;
    }
    if (customerId.isNotEmpty) {
      data['customer_id'] = customerId;
    }
    if (serviceId.isNotEmpty) {
      data['service_id'] = serviceId;
    }
    if (variationCode.isNotEmpty) {
      data['variation_code'] = variationCode;
    }
    if (varianceCode.isNotEmpty) {
      data['variance_code'] = varianceCode;
    }
    if (billName.isNotEmpty) {
      data['bill_name'] = billName;
    }
    return data;
  }

  BillPaymentDto copyWith({
    int? amount,
    String? phoneNumber,
    String? pin,
    String? customerId,
    String? serviceId,
    String? variationCode,
    String? varianceCode,
    String? billName,
  }) {
    return BillPaymentDto(
      amount: amount ?? this.amount,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      pin: pin ?? this.pin,
      customerId: customerId ?? this.customerId,
      serviceId: serviceId ?? this.serviceId,
      variationCode: variationCode ?? this.variationCode,
      varianceCode: varianceCode ?? this.varianceCode,
      billName: billName ?? this.billName,
    );
  }

  @override
  List<Object?> get props => [
        amount,
        phoneNumber,
        pin,
        customerId,
        serviceId,
        variationCode,
        varianceCode,
        billName
      ];
}
