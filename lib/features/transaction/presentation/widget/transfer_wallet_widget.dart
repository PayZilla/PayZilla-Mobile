import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';

import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class TransferWalletCard extends StatelessWidget {
  const TransferWalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dsProvider = context.watch<DashboardProvider>();
    final money = context.money();
    return SizedBox(
      height: context.getHeight(0.05),
      child: ListView.builder(
        itemCount: dsProvider.getWalletsResponse.data?.length ?? 0,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final data = dsProvider.getWalletsResponse.data?[index];
          return Container(
            height: context.getHeight(0.05),
            width: context.getWidth(0.9),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: Corners.mdBorder,
              color: AppColors.textHeaderColor,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                LocalSvgImage(
                  atmLineSvg,
                  width: double.infinity,
                  color: AppColors.appGreen,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Insets.dim_22,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.textHeaderColor.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data != null
                            ? money.formatValue(
                                double.tryParse(data.balance)! * 100,
                              )
                            : money.formatValue(0),
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
        },
      ),
    );
  }
}
