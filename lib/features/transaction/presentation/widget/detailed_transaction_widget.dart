import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class DetailedTransactionWidget extends StatelessWidget {
  const DetailedTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final money = Money();
    final data = context.read<TransactionHistoryProvider>();
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
          DateUtil.covertStringToDate(data.transactionModel.date)
              .timeAgo()
              .capitalize(),
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
                      'Amount transferred',
                      money.formatValue(data.transactionModel.amount),
                    ),
                    const YBox(Insets.dim_14),
                    const Divider(),
                    const YBox(Insets.dim_6),
                    detailsInfoWidget(
                      context,
                      'Fee charged',
                      money.formatValue(0),
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
                      data.transactionModel.status,
                    ),
                    const YBox(Insets.dim_14),
                    detailsInfoWidget(
                      context,
                      'Bank Name',
                      '',
                      rightColor: const Color(0xffA2B1CD),
                    ),
                    const YBox(Insets.dim_6),
                    const Divider(),
                    detailsInfoWidget(
                      context,
                      'Account number',
                      '',
                      rightColor: const Color(0xffA2B1CD),
                    ),
                    const YBox(Insets.dim_6),
                    detailsInfoWidget(
                      context,
                      'Account name',
                      '',
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
                      'Transaction reference',
                      data.transactionModel.reference,
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
