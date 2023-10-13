import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ReferralScreen extends StatelessWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authPV = context.watch<AuthProvider>();
    return AppScaffold(
      body: Column(
        children: [
          LocalSvgImage(referralCodeSvg),
          const YBox(Insets.dim_40),
          Center(
            child: RichText(
              text: TextSpan(
                text: 'Here’s ₦20  ',
                style: context.textTheme.bodyMedium!.apply(
                  color: AppColors.textHeaderColor,
                  fontSizeDelta: 16,
                  fontWeightDelta: 12,
                ),
                children: [
                  TextSpan(
                    text: 'free ',
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: AppColors.black,
                          fontWeightDelta: 12,
                          fontSizeDelta: 16,
                        ),
                  ),
                  TextSpan(
                    text: 'on us! ',
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: AppColors.textHeaderColor,
                          fontWeightDelta: 12,
                          fontSizeDelta: 16,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const YBox(Insets.dim_16),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.dim_40),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Share your referral link and earn ',
                  style: context.textTheme.bodyMedium!.apply(
                    color: AppColors.textBodyColor,
                    fontSizeDelta: 4,
                    fontWeightDelta: 1,
                  ),
                  children: [
                    TextSpan(
                      text: '₦',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: AppColors.textBodyColor,
                            fontWeightDelta: 1,
                            fontSizeDelta: 4,
                          ),
                    ),
                    TextSpan(
                      text: '20',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: AppColors.textBodyColor,
                            fontWeightDelta: 1,
                            fontSizeDelta: 4,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const YBox(Insets.dim_34),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.borderColor,
              borderRadius: Corners.mdBorder,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: Insets.dim_24,
              horizontal: Insets.dim_16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  PhosphorIcons.copy,
                  size: Insets.dim_24,
                  color: AppColors.textBodyColor,
                ).onTap(
                  () => authPV.user.referralCode.toClipboard(
                    feedbackMsg: 'Payment Link copied to clipboard',
                  ),
                ),
                Text(
                  authPV.user.referralCode,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBodyColor,
                  ),
                ),
                const Text(
                  'Share',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ).onTap(
                  () async {
                    await shareReferralLink(
                      authPV.user.referralCode,
                    );
                  },
                ),
              ],
            ),
          ),
          const YBox(Insets.dim_40),
          Divider(
            color: AppColors.black.withOpacity(0.5),
            indent: Insets.dim_24,
            endIndent: Insets.dim_24,
          ),
          const Spacer(),
          /* Note(Dev)=> this was deprecated for subsequent release
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.dim_40),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Get ₦3 ',
                  style: context.textTheme.bodyMedium!.apply(
                    color: AppColors.textHeaderColor,
                    fontSizeDelta: 14,
                    fontWeightDelta: 12,
                  ),
                  children: [
                    TextSpan(
                      text: 'free',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: AppColors.black,
                            fontWeightDelta: 12,
                            fontSizeDelta: 14,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const YBox(Insets.dim_4),
          Text(
            'For any account you connects',
            style: context.textTheme.bodyMedium!.apply(
              color: AppColors.textBodyColor,
              fontSizeDelta: 2,
              fontWeightDelta: 1,
            ),
          ),
          const YBox(Insets.dim_60),
          Row(
            children: [
              socialAuthWidget(googleSvg),
              const XBox(Insets.dim_24),
              socialAuthWidget(appleSvg),
            ],
          ),*/
        ],
      ),
    );
  }

  Future<void> shareReferralLink(String ref) async {
    await Share.share(
      'Hi there 👋, use my referral code to sign up to PayZilla: *$ref*',
    );
  }
}
