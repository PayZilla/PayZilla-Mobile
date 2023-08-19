import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class AllTransactionsScreen extends StatelessWidget {
  const AllTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<TransactionProvider>();
    final money = Money();
    return AppScaffold(
      useBodyPadding: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          FractionallySizedBox(
            heightFactor: tp.isDetailedVisible ? .3 : .35,
            alignment: Alignment.topCenter,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                color: AppColors.textHeaderColor,
                borderRadius: BorderRadius.only(
                  topLeft: Corners.mdRadius,
                  topRight: Corners.mdRadius,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: LocalSvgImage(allTransactSvg),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: LocalSvgImage(allTransactSvg),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: Insets.dim_24,
                        right: Insets.dim_24,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppBoxedButton(
                            color: AppColors.white,
                            onPressed: () {
                              if (tp.isDetailedVisible) {
                                tp.isDetailedVisibleMethod(val: false);
                              } else {
                                AppNavigator.of(context).pop();
                              }
                            },
                          ),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current balance',
                                    style:
                                        context.textTheme.bodyMedium!.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: 0.30,
                                    ),
                                  ),
                                  const YBox(Insets.dim_12),
                                  Row(
                                    children: [
                                      Text(
                                        tp.isBalanceVisible
                                            ? '********'
                                            : money.formatValue(1252500),
                                        style: context.textTheme.bodyMedium!
                                            .copyWith(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => tp.isVisibleMethod(
                                          val: !tp.isBalanceVisible,
                                        ),
                                        icon: Icon(
                                          tp.isBalanceVisible
                                              ? Icons.remove_red_eye_outlined
                                              : Icons.remove_red_eye_rounded,
                                          color:
                                              AppColors.white.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const YBox(Insets.dim_16),
                                  Text(
                                    'Bank account : 2564  8546  8421  1121',
                                    style:
                                        context.textTheme.bodyMedium!.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(Insets.dim_10),
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: LocalSvgImage(
                                  transferSvg,
                                  height: Insets.dim_26,
                                ),
                              ).onTap(() {
                                Log().debug('To refresh this page');
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          FractionallySizedBox(
            heightFactor: tp.isDetailedVisible ? .7 : .65,
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                left: Insets.dim_24,
                right: Insets.dim_24,
              ),
              child: tp.isDetailedVisible
                  ? const DetailedTransactionWidget()
                  : Column(
                      children: [
                        const YBox(Insets.dim_24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedContainer(
                              duration: 3.milliseconds,
                              width: tp.isSearchVisible ? 0 : null,
                              height: tp.isSearchVisible ? 0 : null,
                              child: Text(
                                'Transaction history',
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: AppColors.textHeaderColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              child: AnimatedContainer(
                                duration: 2.seconds,
                                width: !tp.isSearchVisible ? 0 : null,
                                height: !tp.isSearchVisible ? 0 : null,
                                child: SearchTextInputField(
                                  onCancelPressed: () =>
                                      tp.isSearchVisibleMethod(
                                    val: !tp.isSearchVisible,
                                  ),
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: 3.milliseconds,
                              width: tp.isSearchVisible ? 0 : null,
                              height: tp.isSearchVisible ? 0 : null,
                              child: Visibility(
                                visible: !tp.isSearchVisible,
                                child: IconButton(
                                  onPressed: () => tp.isSearchVisibleMethod(
                                    val: !tp.isSearchVisible,
                                  ),
                                  icon: const Icon(
                                    PhosphorIcons.magnifyingGlass,
                                    color: Colors.black,
                                    size: 28,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const Expanded(
                          child: TransactionList(
                            edgeInsets: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
