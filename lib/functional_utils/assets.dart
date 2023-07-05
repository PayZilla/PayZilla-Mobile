// bath assets (svgs and pngs) path
const String baseSvgPath = 'assets/svgs';
const String basePngPath = 'assets/pngs';

// app logo path
final String logoSvg = 'logo'.svg;
final String logoWithNamePng = 'logo_and_name'.png;
final String logoPng = 'logo'.png;

// Onboarding screen assets
final String onb1 = 'on1'.png;
final String onb2 = 'device'.png;
final String onb2b = 'device_top'.png;
final String onb3 = 'card_phone'.png;
final String onb3b = 'card_top'.png;
final String imgPlaceholder = 'img_place_holder'.png;

// Onboarding country assets
final String nigeriaSvg = 'nigeria'.flagSvg;
final String canadaSvg = 'canada'.flagSvg;
final String chinaSvg = 'china'.flagSvg;
final String indonesiaSvg = 'indonesia'.flagSvg;
final String netherlandsSvg = 'netherlands'.flagSvg;
final String singaporeSvg = 'singapore'.flagSvg;
final String usaSvg = 'usa'.flagSvg;

// login screen assets
final String googleSvg = 'google'.svg;
final String appleSvg = 'apple'.svg;

// recovery screen assets
final String recoverySvg = 'recovery'.svg;

// biometric screen assets
final String biometricSvg = 'biometric'.svg;

// reasons screen assets
final String r1 = 'r1'.reasonsSvg;
final String r2 = 'r2'.reasonsSvg;
final String r3 = 'r3'.reasonsSvg;
final String r4 = 'r4'.reasonsSvg;
final String r5 = 'r5'.reasonsSvg;
final String r6 = 'r6'.reasonsSvg;

// verification screen assets
final String bvnSvg = 'bvn'.verificationSvg;
final String idCardSvg = 'passport'.verificationSvg;
final String driverLicenseSvg = 'drivers'.verificationSvg;
// nav icons
final String homeActive = 'home_active'.navSvg;
final String homeInActive = 'home_inactive'.navSvg;
final String walletInactive = 'wallet_inactive'.navSvg;
final String referralInactive = 'referral_inactive'.navSvg;
final String payBillsInactive = 'pay_bills_inactive'.navSvg;

// dashboard
final String noTransaction = 'no_transaction'.svg;
final String notificationBell = 'notification_bell'.svg;
final String verificationIcon = 'verirication_complete_icon'.svg;
final String fingerPrint = 'fingerprint'.png;
final String referralCard = 'referral_card_bg'.png;
final String dashboardBg = 'dashboard_background_1'.png;
final String fingerprint = 'fingerprint'.png;

// profile icons
final String faqLogoIcon = 'faq_icon'.profileSvg;
final String helpAndSupportIcon = 'help_and_support_icon'.profileSvg;
final String intercomIcon = 'intercom_icon'.profileSvg;
final String instagramIcon = 'instagram_icon'.profileSvg;
final String twitterIcon = 'twitter_icon'.profileSvg;
final String facebookIcon = 'facebook_icon'.profileSvg;

//wallet
final String debitTransaction = 'transaction_out'.walletSvg;
final String creditTransaction = 'transaction_in'.walletSvg;
final String walletCardPatternedBg = 'wallet_balance_bg'.png;

//security
final String playStore = 'playstore_icon'.png;
final String deleteAccount = 'delete_thrash'.svg;

//transaction
final String pendingIcon = 'transaction_pending'.svg;
final String successIcon = 'transaction_successful'.svg;
final String failedIcon = 'transaction_failed'.svg;
final String deleteFileIcon = 'delete-file'.png;

// extensions
extension ImageExtension on String {
  // get png paths
  String get png => '$basePngPath/$this.png';
  // get svgs path
  String get svg => '$baseSvgPath/$this.svg';
  //get country svg path
  String get flagSvg => '$baseSvgPath/country_flags/$this.svg';

  //get reasons svg path
  String get reasonsSvg => '$baseSvgPath/reasons/$this.svg';

  //get verification svg path
  String get verificationSvg => '$baseSvgPath/verification/$this.svg';

  // get nav assets
  String get navSvg => '$baseSvgPath/nav/$this.svg';
  //get wallet assets
  String get walletSvg => '$baseSvgPath/wallet/$this.svg';
  // get profile assets
  String get profileSvg => '$baseSvgPath/profile/$this.svg';
  // get profile assets
  String get transactionSvg => '$baseSvgPath/transaction/$this.svg';
}
