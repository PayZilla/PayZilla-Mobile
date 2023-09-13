import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/image.dart';
import 'package:pay_zilla/functional_utils/assets.dart';
import 'package:pay_zilla/functional_utils/extensions/context_extension.dart';

class AtmCardWidget extends StatelessWidget {
  const AtmCardWidget({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final money = context.money();

    return Container(
      height: context.getHeight(0.2),
      width: context.getWidth(0.9),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: Corners.mdBorder,
        color: color,
      ),
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
              padding: const EdgeInsets.symmetric(horizontal: Insets.dim_22),
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
                  Text(
                    '****   ****   ****   1121',
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
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
              padding: const EdgeInsets.symmetric(horizontal: Insets.dim_22),
              child: Row(
                children: [
                  Text(
                    money.formatValue(2000000),
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  LocalSvgImage(atmLogoSvg),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  * ATM Card Widget 2
//  * Use this in the card widget

class AtmCardWidget2 extends StatelessWidget {
  const AtmCardWidget2({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.getHeight(0.21),
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
              LocalSvgImage(atmLogoSvg),
              const Spacer(),
              Text(
                '****   ****   ****   1121',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              Text(
                '13/24',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.white.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Text(
                'Tommy Jason',
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

class AtmCardWidget3 extends StatelessWidget {
  const AtmCardWidget3({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.getHeight(0.24),
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
          const YBox(Insets.dim_24),
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
            '2564   8546   8421   1121',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const Spacer(),
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
                      'John Williams',
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
                      '13/24',
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
          )
        ],
      ),
    );
  }
}
