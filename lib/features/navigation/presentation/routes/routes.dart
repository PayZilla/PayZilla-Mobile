import 'package:pay_zilla/features/navigation/navigation.dart';

class AppRoutes {
//splash screen first
  static const splash = '/splash';

  //onboarding screen and where you can go and come from Onboarding
  static const onboarding = '/onboarding';
  static const onboardingAuth = '/onboarding/auth';

  // recovery screen
  static const authToRecovery = '/auth/recovery';
  static const authToSignUp = '/auth/sign-up';
  static const recoveryToVerify = '/auth/recovery/verify';
  static const verifyToPassword = '/auth/recovery/verify/new-password';

  // biometric
  static const biometric = '/biometric';

  // country of residence, onboarding reasons, pin
  static const pin = '/pin';

  static const country = '/country';
  static const countryToBvn = '/country/bvn-verification';
  static const bvnToReasons = '/country/bvn-verification/reasons';
  static const reasonsToPin = '/country/bvn-verification/reasons/pin';

  static String tab(AppNavTab tab) {
    return '/tab/${tab.toString().split('.').last}';
  }

  //bottom tab routes
  static const home = '/tab/home';
  static const myCard = '/tab/card';
  static const activity = '/tab/activity';
  static const profile = '/tab/profile';

  // dashboard routes
  static const homeToNotifications = '/tab/home/notifications';
  static const homeToLogout = '/tab/home/logout';
  static const allTransactions = '/tab/home/all-transactions';
  static const transfer = '/tab/home/transfer';
  static const bankTransfer = '/tab/home/transfer-bank';
  static const sendMoney = '/tab/home/transfer/send-money';

  static const successfulTransaction = '/transfer-success';

  static const billPaymentVerification = '/tab/home/bill-payment-verification';

  /// Scanner routes
  static const qrScan = '/tab/home/qr-scanner';
  static const qrShowScan = '/tab/home/qr-show-scanner';
  static const scanQrScreen = '/tab/home/qr-scanner/scan-qr-screen';

  // My cards
  static const startCreateCard = '/tab/card/start-create-card';
  static const chooseCardStyle =
      '/tab/card/start-create-card/choose-card-style';
  static const cardDetailScreen = '/tab/card/card-details';

  // profile routes
  static const referral = '/tab/profile/referral';
  static const accountInfo = '/tab/profile/account-info';
  static const editAccountInfo = '/tab/profile/account-info/edit';
  static const contact = '/tab/profile/contact';
  static const language = '/tab/profile/language';
  static const general = '/tab/profile/general';
  static const password = '/tab/profile/password';
  static const faq = '/tab/profile/faq';

  // funding account details routes
  static const fundingAccountDetails = '/tab/home/funding-account-details';
  static const fromHomeToPin = '/tab/home/pin';
  static const topUpAmountScreen = '/tab/home/top-up-amount';
}
