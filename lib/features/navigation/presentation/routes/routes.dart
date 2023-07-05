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
  static const country = '/country';
  static const countryToReasons = '/country/reasons';
  static const reasonsToPin = '/country/reasons/pin';
  static const pinToBvn = '/country/reasons/pin/bvn-verification';

  // bvn verification

  //dashboard screen
  static const profileAvatarUpload = '/tab/home/profile-avatar-upload';

  static String tab(AppNavTab tab) {
    return '/tab/${tab.toString().split('.').last}';
  }
}
