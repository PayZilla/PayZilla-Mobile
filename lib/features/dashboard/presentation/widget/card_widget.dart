import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/image.dart';
import 'package:pay_zilla/functional_utils/assets.dart';
import 'package:pay_zilla/functional_utils/extensions/context_extension.dart';

class AtmCardWidget extends StatelessWidget {
  const AtmCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final money = context.money();

    return Container(
      height: context.getHeight(0.2),
      width: context.getWidth(0.9),
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: Corners.mdBorder,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          LocalSvgImage(
            atmLineSvg,
            width: double.infinity,
            color: const Color(0xff1DAB87),
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
