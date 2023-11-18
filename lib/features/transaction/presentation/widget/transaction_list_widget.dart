import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

/**!SECTION
 * 
 * 1. create a skeletal widget for transaction loading 
 * 2. handle transaction lists and single view  
 */

class TransactionList extends StatefulWidget {
  const TransactionList({
    super.key,
    this.edgeInsets,
    required this.useRefresh,
  });

  final EdgeInsets? edgeInsets;
  final bool useRefresh;

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    final transactionsProvider = context.watch<TransactionHistoryProvider>();
    final money = context.money();
    return RefreshIndicator(
      backgroundColor: AppColors.textHeaderColor,
      onRefresh: () async {
        if (widget.useRefresh) {
          transactionsProvider.fetchMore(
              transactionsProvider.pageNumCount, context);
        }
      },
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        controller: transactionsProvider.controller,
        separatorBuilder: (context, index) => const YBox(Insets.dim_26),
        itemCount: transactionsProvider.transactionsFetched.length,
        itemBuilder: (context, index) {
          final data = transactionsProvider.transactionsFetched[index];
          return GestureDetector(
            onTap: () {
              transactionsProvider.onTransactionTapped(data, context);
              AppNavigator.of(context).push(AppRoutes.allTransactions);
            },
            child: Container(
              height: 50,
              margin: widget.edgeInsets ??
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
                      data.type == 'debit' ? sentSvg : depositSvg,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const XBox(Insets.dim_24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.category.replaceAll('_', ' ').capitalize(),
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: AppColors.textHeaderColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          letterSpacing: 0.30,
                        ),
                      ),
                      const YBox(Insets.dim_6),
                      Text(
                        data.type.capitalize(),
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: data.type == 'debit'
                              ? AppColors.borderErrorColor
                              : AppColors.appGreen,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 0.30,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    money.formatValue(data.amount * 100),
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
      ),
    );
  }
}
