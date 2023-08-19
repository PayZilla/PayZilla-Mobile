import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DetailedTransactionWidget extends StatelessWidget {
  const DetailedTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final money = Money();

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const YBox(Insets.dim_24),
        Text(
          'Transaction Details',
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.textHeaderColor,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        const YBox(Insets.dim_24),
        Text(
          'Aug 14th, 16:59',
          style: context.textTheme.bodySmall!.copyWith(
            color: AppColors.textBodyColor,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 0.30,
          ),
        ),
        const YBox(Insets.dim_24),
        SizedBox(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Insets.dim_50,
                height: double.infinity,
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: Insets.dim_12),
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: Corners.xsBorder,
                ),
                child: const Icon(PhosphorIcons.bank),
              ),
              const XBox(Insets.dim_22),
              Expanded(
                child: Column(
                  children: [
                    const YBox(Insets.dim_12),
                    detailsInfoWidget(
                      context,
                      'Transfer to bank',
                      money.formatValue(500000),
                    ),
                    const YBox(Insets.dim_14),
                    detailsInfoWidget(
                      context,
                      'Oder amount',
                      money.formatValue(500000),
                      rightColor: const Color(0xffA2B1CD),
                    ),
                    const YBox(Insets.dim_6),
                    const Divider(),
                    const YBox(Insets.dim_6),
                    detailsInfoWidget(
                      context,
                      'Fee charged',
                      money.formatValue(00),
                      rightColor: const Color(0xffA2B1CD),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        const YBox(Insets.dim_12),
        SizedBox(
          height: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Insets.dim_50,
                height: double.infinity,
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: Insets.dim_12),
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: Corners.xsBorder,
                ),
              ),
              const XBox(Insets.dim_22),
              Expanded(
                child: Column(
                  children: [
                    const YBox(Insets.dim_12),
                    detailsInfoWidget(
                      context,
                      'Status',
                      'Success',
                    ),
                    const YBox(Insets.dim_14),
                    detailsInfoWidget(
                      context,
                      'Bank Name',
                      'PalmPay',
                      rightColor: const Color(0xffA2B1CD),
                    ),
                    const YBox(Insets.dim_6),
                    const Divider(),
                    detailsInfoWidget(
                      context,
                      'Account number',
                      '890000836',
                      rightColor: const Color(0xffA2B1CD),
                    ),
                    const YBox(Insets.dim_6),
                    detailsInfoWidget(
                      context,
                      'Account name',
                      'Emmanuel Akinjole',
                      rightColor: const Color(0xffA2B1CD),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        const YBox(Insets.dim_12),
        SizedBox(
          height: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Insets.dim_50,
                height: double.infinity,
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: Insets.dim_12),
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: Corners.xsBorder,
                ),
              ),
              const XBox(Insets.dim_22),
              Expanded(
                child: Column(
                  children: [
                    const YBox(Insets.dim_12),
                    detailsInfoWidget(
                      context,
                      'Transaction number',
                      '67567789999',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        AppButton(
          textTitle: 'Share Receipt',
          action: () {},
        ),
        const YBox(Insets.dim_32),
      ],
    );
  }

  Widget detailsInfoWidget(
    BuildContext context,
    String rightText,
    String leftText, {
    Color? rightColor = AppColors.textBodyColor,
    Color? leftColor = AppColors.textBodyColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          rightText,
          style: context.textTheme.bodySmall!.copyWith(
            color: leftColor ?? AppColors.textBodyColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: 0.30,
          ),
        ),
        Text(
          leftText,
          style: context.textTheme.bodySmall!.copyWith(
            color: rightColor ?? AppColors.textBodyColor,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 0.30,
          ),
        ),
      ],
    );
  }
}
