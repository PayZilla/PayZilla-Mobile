class TransferValidateModel {
  TransferValidateModel({
    required this.name,
    required this.accountNumber,
    required this.bankCode,
    required this.bankName,
    required this.avatarUrl,
  });

  factory TransferValidateModel.fromJson(Map<String, dynamic> json) {
    return TransferValidateModel(
      name: json['name'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
      bankCode: json['bankCode'] ?? '',
      bankName: json['bankName'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
    );
  }
  final String name;
  final String accountNumber;
  final String bankCode;
  final String bankName;
  final String avatarUrl;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['accountNumber'] = accountNumber;
    data['bankCode'] = bankCode;
    data['bankName'] = bankName;
    data['avatarUrl'] = avatarUrl;
    return data;
  }
}
