enum WithdrawalCorridorTypeEnum {
  cadToCadInterac,
  ngnToCadBankAccount,
  ngnToNgnBankAccount,
  cadToCadBankAccount,
}

extension WithdrawalCorridorTypeExtension on WithdrawalCorridorTypeEnum {
  String get name {
    switch (this) {
      case WithdrawalCorridorTypeEnum.cadToCadInterac:
        return '0';
      case WithdrawalCorridorTypeEnum.ngnToCadBankAccount:
        return '1';
      case WithdrawalCorridorTypeEnum.ngnToNgnBankAccount:
        return '2';
      case WithdrawalCorridorTypeEnum.cadToCadBankAccount:
        return '3';
    }
  }
}
