import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';

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
  final updateUserProfile = '/v3/User/profile';
  final getBeneficiaries = '/User/GetBeneficiaryByUserId';
  final getVerificationProgress = '/User/verificationprogress';

  final verifyUsername = '/User/verifyusername';

  final uploadProfilePicture = '/User/v2/profile/picture';

  final updateUserName = '/User/username';

  final requestOnfidoToken = '/User/SdkToken';

  final requestOnfidoCheck = '/User/onfidoCheck';
}

class _TransactionEndpoints {
  final getTransactionHistory = '/Transactions';
}

class _RateEndpoints {
  final getExchangeRate = '/Rate/exchangerate';
}

// user endpoints
class _AppPolicyEndpoints {
  final tcp = '${AppConfig.clientUrl}/policies';
  final faqs = '${AppConfig.clientUrl}/faqs';
  final kycPolicy = '${AppConfig.clientUrl}/kyc-policy';
}

//Maps endpoints
class _MapEndpoints {
  String suggestion(String query, String country, String sessionToken) =>
      "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&types=address&language=$kLanguage&components=country:$country&key=${dotenv.env['PLACES_API_KEY']}&sessiontoken=$sessionToken";

  String completePlaceId(String placeId, String sessionToken) =>
      "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=${dotenv.env['PLACES_API_KEY']}&sessiontoken=$sessionToken";
}

class _OTPEndpoints {
  final otp = '/User/RequestVerificationOTP';
}

class _AccountEndpoints {
  final pinSetup = '/accounts/pin/setup';
}

class _OtherEndpoints {
  final getOccupation = '/Occupation';

  final getQuestionnaireGroupId = '/Questionnaire/group';
  String submitQuestionnaire(String groupId) =>
      '/Questionnaire/answer/$groupId';
  //same thing could be done here.
  String getQuestionnaires(String groupId) => '/Questionnaire/$groupId';
}

class _WalletEndpoints {
  final getUserWallet = '/Wallet/userwallets';
  final getOccupation = '/Occupation';
  final getOTP = '/User/RequestVerificationOTP';
  final getUserWallets = '/Wallet/userwallets';
  final getFundNgnWalletDetails = '/Transactions/FundNgnWallet';
  final String accountLookup = '/Transactions/accountlookup';

  String getWalletCurrency(String currency) =>
      '/Wallet?walletCurrency=$currency';
  String getTransactions(int pageNumber, int pageSize) =>
      '/v2/user/transactions?pageNumber=$pageNumber&pageSize=$pageSize';
  String sendWithdrawalRequest(String currency) =>
      '/Transactions/$currency/Withdrawal';
  String getInteracDetails(String email) => '/User/InteracDetails?email=$email';

  String getWalletFundingInformation(String currencyCode) =>
      '/$currencyCode/FundingInformation';

  String addWallet(String currencyCode) => '/$currencyCode/wallet';

  String getAutoDepositeDetails() => '/Transactions/autoDepositDetails';
}

class _SecurityEndpoints {
  final toggle2FA = '/Barcode/UpdateUser2FaStatus';
  final generateBarcode = '/Barcode/GenerateBarcode';
  final deleteUser = '/User';
}

class _BankEndpoints {
  String getBanks(
    String countryCode, {
    int? bankVersion,
    int? bankMethod,
  }) {
    if (bankMethod != null) {
      return '/Transactions/banks?countryCode=$countryCode&bankVersion=$bankVersion&bankMethod=$bankMethod';
    }
    return '/Transactions/banks?countryCode=$countryCode&bankVersion=$bankVersion';
  }
}

// endpoints

final authEndpoints = _AuthEndpoints();
final transactionEndpoints = _TransactionEndpoints();
final walletEndpoints = _WalletEndpoints();
final userEndpoints = _UserEndpoints();
final rateEndpoints = _RateEndpoints();
final appPolicyEndpoints = _AppPolicyEndpoints();
final mapsEndpoints = _MapEndpoints();
final otherEndpoints = _OtherEndpoints();
final otpEndpoints = _OTPEndpoints();
final securityEndpoints = _SecurityEndpoints();
final bankEndpoints = _BankEndpoints();
final accountEndpoints = _AccountEndpoints();
