import 'package:pay_zilla/features/navigation/navigation.dart';

class AppRoutes {
//splash screen first
  static const splash = '/splash';

  //onboarding screen and where you can go and come from Onboarding
  static const onboarding = '/onboarding';
  static const onboardingSignUp = '/onboarding/signUp';

  //dashboard screen
  static const profileAvatarUpload = '/tab/home/profile-avatar-upload';

  //auth screen
  static const login = '/login';
  static const signUp = '/sign-up';
  static const viewTermsOrPolicy = '/sign-up/tcPolicy';

  //profile update
  static const profileInfo = '/profile-info';
  static const addressInfo = '/profile-info/address-info';
  static const contactInfo = '/profile-info/address-info/contact-info';
  static const otp = '/profile-info/address-info/contact-info/otp';

  // questionnaire
  static const questionnaire = '/questionnaire';

  static String tab(AppNavTab tab) {
    return '/tab/${tab.toString().split('.').last}';
  }

  //home tab routes
  static const home = '/tab/home';
  static const profile = '/tab/profile';

  //wallet tab routes
  static const wallet = '/tab/wallet';
  static const walletInteracDetails = '/tab/wallet/interacDetails';
  static const walletFundingInformation = '/tab/wallet/fundingInformation';
  static const pendingTransactions = '/tab/wallet/pendingTransactions';
  static const withdrawInterac = '/tab/wallet/withdrawInterac';
  static const withdrawNgn = '/tab/wallet/withdrawNgn';
  static const withdrawalSummary = '/tab/wallet/withdrawalSummary';
  static const addWallet = '/tab/wallet/addWallet';

  //profile tab routes
  static const aboutPZillaichange = '/tab/profile/about-PZillaichange';
  static const helpAndSupport = '/tab/profile/help-and-support';
  static const security = '/tab/profile/security';
  static const deleteAccount = '/tab/profile/security/deleteAccount';
  static const deactivateAccount = '/tab/profile/security/deactivateAccount';
  static const logout = '/tab/profile/security/logout';

  // send money routes
  static const smWalletChoices = '/tab/sm-wallet-choices';
}
