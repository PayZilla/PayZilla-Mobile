import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
    this.edgeInsets,
  });

  final EdgeInsets? edgeInsets;

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<TransactionProvider>();
    final money = context.money();
    return ListView.separated(
      separatorBuilder: (context, index) => const YBox(Insets.dim_26),
      itemCount: 12,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            tp.onTransactionTapped(index);
          },
          child: Container(
            height: 50,
            margin: edgeInsets ??
                const EdgeInsets.symmetric(
                  horizontal: Insets.dim_22,
                ),
            color: AppColors.white,
            child: Row(
              children: [
                Container(
                  height: Insets.dim_100,
                  width: Insets.dim_54,
                  decoration: BoxDecoration(
                    borderRadius: Corners.mdBorder,
                    color: AppColors.borderColor,
                  ),
                  child: LocalSvgImage(
                    index.isEven ? sentSvg : depositSvg,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const XBox(Insets.dim_24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'To Tunde kamoru',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textHeaderColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        letterSpacing: 0.30,
                      ),
                    ),
                    const YBox(Insets.dim_6),
                    Text(
                      index.isEven ? 'Sent' : 'Deposit',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textBodyColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: 0.30,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  money.formatValue(2000000),
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.btnPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    letterSpacing: 0.30,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
