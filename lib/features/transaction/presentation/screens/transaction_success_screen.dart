import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class TransactionSuccessArgs {
  TransactionSuccessArgs(this.name, this.amount);

  final String name;
  final String amount;
}

class TransactionSuccessScreen extends StatefulWidget {
  const TransactionSuccessScreen({
    super.key,
    required this.args,
  });

  final TransactionSuccessArgs args;

  @override
  State<TransactionSuccessScreen> createState() =>
      _TransactionSuccessScreenState();
}

class _TransactionSuccessScreenState extends State<TransactionSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final money = Money();
    return AppScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const YBox(Insets.dim_24),
          LocalSvgImage(successfulTransferSvg),
          const YBox(Insets.dim_32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.dim_50),
            child: Text(
              'Transfer Successful',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.textHeaderColor,
                fontWeight: FontWeight.w700,
                fontSize: 24,
                letterSpacing: 0.30,
              ),
            ),
          ),
          const YBox(Insets.dim_12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.dim_50),
            child: Text(
              'Transfers are reviewed which may result in delays or funds being frozen',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.textBodyColor,
                fontWeight: FontWeight.w400,
                fontSize: 11,
                letterSpacing: 0.30,
              ),
            ),
          ),
          YBox(context.getHeight(0.09)),
          Container(
            decoration: BoxDecoration(
              color: AppColors.textHeaderColor.withOpacity(0.05),
              borderRadius: Corners.mdBorder,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.dim_26,
              vertical: Insets.dim_12,
            ),
            child: Text(
              money.formatValue(8504888),
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.textHeaderColor,
                fontWeight: FontWeight.w700,
                fontSize: 32,
              ),
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: AppButton(
              textTitle: 'Back to Home',
              action: () => AppNavigator.of(context).push(AppRoutes.home),
            ),
          ),
          const YBox(Insets.dim_22),
        ],
      ),
    );
  }
}
