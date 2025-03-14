import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/assets.dart';
import 'package:pay_zilla/functional_utils/extensions/context_extension.dart';
import 'package:provider/provider.dart';

class AtmCardWidget extends StatelessWidget {
  const AtmCardWidget({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final money = context.money();
    final dsProvider = context.watch<DashboardProvider>();
    final user = context.watch<AuthProvider>().user;
    return user.hasVerifiedPhoneNumber
        ? Container(
            height: context.getHeight(0.2),
            width: context.getWidth(0.9),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: Corners.mdBorder,
              color: color,
            ),
            child: ListView.builder(
              itemCount: dsProvider.getWalletsResponse.data?.length ?? 0,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final data = dsProvider.getWalletsResponse.data?[index];
                return SizedBox(
                  height: context.getHeight(0.2),
                  width: context.getWidth(0.9),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      LocalSvgImage(
                        atmLineSvg,
                        width: double.infinity,
                        color: AppColors.appGreen,
                      ),
                      FractionallySizedBox(
                        heightFactor: 0.7,
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Insets.dim_22,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.textHeaderColor.withOpacity(0.5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const YBox(Insets.dim_4),
                              Row(
                                children: [
                                  LocalSvgImage(atmChipSvg),
                                  const XBox(Insets.dim_22),
                                  LocalSvgImage(atmNfcSvg),
                                ],
                              ),
                              const YBox(Insets.dim_4),
                            ],
                          ),
                        ),
                      ),
                      FractionallySizedBox(
                        heightFactor: 0.3,
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: AppColors.appSecondaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Insets.dim_22,
                          ),
                          child: Row(
                            children: [
                              if (dsProvider.showBalance)
                                Text(
                                  money.formatValue(
                                    (double.tryParse(data?.balance ?? '0'))! *
                                        100,
                                  ),
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                )
                              else
                                Text(
                                  'NGN ********',
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              const Spacer(),
                              CupertinoSwitch(
                                onChanged: (value) {
                                  dsProvider.showBalance = value;
                                },
                                value: dsProvider.showBalance,
                                activeColor: AppColors.white,
                                trackColor: color,
                                thumbColor: color,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () async {
                            await dsProvider.getWallets();
                          },
                          icon: const Icon(Icons.refresh_rounded),
                          color: AppColors.white,
                          iconSize: Insets.dim_32,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        : const TempLoadingAtmCard(
            color: AppColors.textHeaderColor,
            height: .14,
            showLoader: false,
            textStatus: '',
          );
  }
}

//  * ATM Card Widget 2
//  * Use this in the card widget

class MyCardsWidget extends StatelessWidget {
  const MyCardsWidget({
    super.key,
    this.color,
    required this.card,
    this.cardLogo,
  });
  final Color? color;
  final CardsModel card;
  final Widget? cardLogo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.getHeight(0.22),
      width: context.getWidth(0.9),
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.only(left: Insets.dim_22),
      decoration: BoxDecoration(
        borderRadius: Corners.mdBorder,
        color: color,
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YBox(Insets.dim_24),
              cardLogo ?? LocalSvgImage(atmLogoSvg),
              const Spacer(),
              Text(
                '****   ****   ****   ${card.last4}',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              Text(
                '${card.expMonth}/${card.expYear}',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.white.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Text(
                card.accountName,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const YBox(Insets.dim_24),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              LocalSvgImage(atmPatternSvg),
              LocalSvgImage(atmPatternSvg),
            ],
          ),
        ],
      ),
    );
  }
}

//  * ATM Card Widget 3

class TempLoadingAtmCard extends StatelessWidget {
  const TempLoadingAtmCard({
    super.key,
    this.color,
    this.height,
    this.showLoader = true,
    this.textStatus = 'Loading...',
  });
  final Color? color;
  final double? height;
  final bool showLoader;
  final String textStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.getHeight(height ?? 0.30),
      width: context.getWidth(0.9),
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.symmetric(horizontal: Insets.dim_22),
      decoration: BoxDecoration(
        borderRadius: Corners.mdBorder,
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const YBox(Insets.dim_16),
          Expanded(
            child: Row(
              children: [
                LocalSvgImage(atmLogoSvg),
                const Spacer(),
                LocalSvgImage(atmGoldChipSvg),
              ],
            ),
          ),
          const Spacer(),
          Text(
            '****   ****   ****   ****',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          if (showLoader) ...[
            const Spacer(),
            const AppCircularLoadingWidget(
              size: 16,
              color: AppColors.white,
            ),
            const Spacer(),
          ],
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card Holder',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.white.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      textStatus,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: 0.30,
                      ),
                    ),
                    const YBox(Insets.dim_24),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Expires',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.white.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '--/--',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: 0.30,
                      ),
                    ),
                    const YBox(Insets.dim_24),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
