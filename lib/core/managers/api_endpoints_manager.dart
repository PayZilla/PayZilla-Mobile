// auth endpoints
class _AuthEndpoints {
  final login = '/auth/login';
  final signUp = '/auth/register';

  final forgotPasswordInitiated = '/auth/forgot-password/initiate';
  final forgotPasswordVerify = '/auth/forgot-password/verify';
  final forgotPasswordReset = '/auth/forgot-password/reset';

  final emailVerificationInitiate = '/auth/email-verification/initiate';
  final emailVerificationVerify = '/auth/email-verification/verify';

  final getKyc = '/kycs';
  final bvnInitialize = '/kycs/bvn/initialize';
  final bvnVerification = '/kycs/bvn/verify';
  final bvnUpdate = '/kycs/bvn/update-name';

  final submitPurpose = '/profile/registration-purpose';
}

// user endpoints
class _UserEndpoints {
  final getUser = '/profile';
  final avatarUpload = '/profile/avatar';
}

class _AccountEndpoints {
  final pinSetup = '/accounts/pin/setup';

  // bills payment
  final billCategories = '/accounts/bill-payment/categories';
  String billCategoryId(String id) => '/accounts/bill-payment/categories/$id';
  String billCategoryServiceId(String id) =>
      '/accounts/bill-payment/variances/$id';
  final payAirtime = '/accounts/bill-payment/airtime';
  final verifyBill = '/accounts/bill-payment/verify';
  final payBill = '/accounts/bill-payment/purchase';

  // cards
  final getCards = '/accounts/cards';
  final initiateCard = '/accounts/cards/add/initiate';
  final finalizeCard = '/accounts/cards/add/finalize';

  // wallets
  final getWallets = '/accounts/wallets';
  final getContacts = '/accounts/contacts';

  // account details info
  final getAccountDetails = '/accounts';
}

class _TransferEndpoints {
  final getBanks = '/accounts/transfer/banks';
  final validateBanksOrWallet = '/accounts/transfer/validate';
  final transferBanksOrWallet = '/accounts/transfer/perform';
}

//others
class _OthersEndpoints {
  final faqs = '/faq';
}

class _NotificationEndpoints {
  final getNotifications = '/notifications';
  String getNotification(String id) => '/notifications/$id';
  String notificationSeen(String id) => '/notifications/$id/read';
  final notificationsSeen = '/notifications/read';
}

class _TransactionsEndpoints {
  final getTransactions = '/accounts/transactions';
  final getTransactionsOverview = '/accounts/transactions/overview';
}

// endpoints

final authEndpoints = _AuthEndpoints();
final userEndpoints = _UserEndpoints();
final accountEndpoints = _AccountEndpoints();
final othersEndpoints = _OthersEndpoints();
final transferEndpoints = _TransferEndpoints();
final notificationEndpoints = _NotificationEndpoints();
final transactionsEndpoints = _TransactionsEndpoints();
