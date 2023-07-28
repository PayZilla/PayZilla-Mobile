// bath assets (svgs and pngs) path
const String baseSvgPath = 'assets/svgs';
const String basePngPath = 'assets/pngs';

const String selfie = 'assets/pngs/selfie.jpg';

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
final String biometricPng = 'biometric'.png;

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
final String homeActive = 'home'.navSvg;
final String homeInActive = 'homeInactive'.navSvg;
final String myCardInactive = 'myCardInactive'.navSvg;
final String myCardActive = 'myCard'.navSvg;
final String activityInactive = 'activityInactive'.navSvg;
final String activityActive = 'activity'.navSvg;
final String profileInactive = 'profileInactive'.navSvg;
final String profileActive = 'profile'.navSvg;
final String scanSvg = 'scan'.navSvg;

// dashboard
final String dataSvg = 'data'.dashboardSvg;
final String depositSvg = 'deposit'.dashboardSvg;
final String electricitySvg = 'electricity'.dashboardSvg;
final String moreSvg = 'more'.dashboardSvg;
final String referEarnSvg = 'refer_earn'.dashboardSvg;
final String safeRideSvg = 'safe_ride'.dashboardSvg;
final String schoolSvg = 'school'.dashboardSvg;
final String sentSvg = 'sent'.dashboardSvg;
final String transferSvg = 'transfer'.dashboardSvg;
final String tvSvg = 'tv'.dashboardSvg;
final String withdrawSvg = 'withdraw'.dashboardSvg;
final String notificationCheckSvg = 'notification_check'.dashboardSvg;
final String rewardSvg = 'reward'.dashboardSvg;
final String paymentSvg = 'payment'.dashboardSvg;
final String cashbackSvg = 'cashback'.dashboardSvg;

// ATM security
final String atmLineSvg = 'atm_line'.atmSvg;
final String atmLogoSvg = 'atm_logo'.atmSvg;
final String atmChipSvg = 'atm_chip'.atmSvg;
final String atmGoldChipSvg = 'atm_gold_chip'.atmSvg;
final String atmNfcSvg = 'nfc'.atmSvg;
final String atmPatternSvg = 'atm_pattern'.atmSvg;
final String atmMultiCardPng = 'atm_multi_card'.png;

// QR code
final String qrBgPng = 'qr_bg'.png;
final String qrBorderSvg = 'qr_border'.qrSvg;
final String qrBoltSvg = 'qr_bolt'.qrSvg;

// profile
final String accountInfoSvg = 'account_info'.profileSvg;
final String contactListSvg = 'contact_list'.profileSvg;
final String generalSvg = 'general'.profileSvg;
final String languageSvg = 'language'.profileSvg;
final String passwordSvg = 'password'.profileSvg;
final String referralSvg = 'referral'.profileSvg;
final String defaultNotificationSvg = 'default_notification'.profileSvg;
final String referralCodeSvg = 'referral_screen'.profileSvg;

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

  //get dashboard svg path
  String get dashboardSvg => '$baseSvgPath/dashboard/$this.svg';

  //get atm svg path
  String get atmSvg => '$baseSvgPath/atm/$this.svg';

  //get verification svg path
  String get verificationSvg => '$baseSvgPath/verification/$this.svg';

  // get nav assets
  String get navSvg => '$baseSvgPath/nav/$this.svg';

  // get qr assets
  String get qrSvg => '$baseSvgPath/qr/$this.svg';

  // get qr assets
  String get profileSvg => '$baseSvgPath/profile/$this.svg';
}
