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
  final qrValidate = '/accounts/transfer/validate';
}

class _AccountEndpoints {
  final pinSetup = '/accounts/pin/setup';

  // bills payment
  final billCategories = '/accounts/bill-payment/categories';
  String billCategoryId(String id) => '/accounts/bill-payment/categories/$id';
  String billCategoryServiceId(String id) =>
      '/accounts/bill-payment/variances/$id';

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

//others
class _OthersEndpoints {
  final faqs = '/faq';
}

// endpoints

final authEndpoints = _AuthEndpoints();
final userEndpoints = _UserEndpoints();
final accountEndpoints = _AccountEndpoints();
final othersEndpoints = _OthersEndpoints();
