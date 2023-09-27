import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/image.dart';
import 'package:pay_zilla/functional_utils/assets.dart';
import 'package:pay_zilla/functional_utils/extensions/context_extension.dart';

class ActivityWalletWidget extends StatelessWidget {
  const ActivityWalletWidget({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: Corners.mdBorder,
        color: color,
      ),
      margin: const EdgeInsets.symmetric(horizontal: Insets.dim_16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          LocalSvgImage(
            atmLineSvg,
            width: double.infinity,
            color: AppColors.appGreen,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Insets.dim_22),
            decoration: BoxDecoration(
              color: AppColors.textHeaderColor.withOpacity(0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Co.payment Cards',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Text(
                  ' ****   1121',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                LocalSvgImage(atmLogoSvg),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
