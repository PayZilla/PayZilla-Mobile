import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class StartCreateCardScreen extends StatefulWidget {
  const StartCreateCardScreen({super.key});

  @override
  State<StartCreateCardScreen> createState() => _StartCreateCardScreenState();
}

class _StartCreateCardScreenState extends State<StartCreateCardScreen> {
  late TransactionProvider transactionP;
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => transactionP.initializeCard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    transactionP = context.watch<TransactionProvider>();
    final authProvider = context.read<AuthProvider>();
    return AppScaffold(
      body: Column(
        children: [
          LocalImage(
            atmMultiCardPng,
            height: context.getHeight(0.45),
          ),
          const Spacer(),
          Text(
            'Create your PayZilla Card',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textHeaderColor,
              fontWeight: FontWeight.w700,
              fontSize: 32,
            ),
          ),
          const YBox(Insets.dim_12),
          Text(
            'The customizable, no hidden fee, instant discount debit or credit card',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textBodyColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const YBox(Insets.dim_44),
          AppSolidButton(
            textTitle: 'Get Free Card',
            showLoading: transactionP.initializeRefRES.isLoading ||
                transactionP.finalizeAddCardRES.isLoading,
            action: () {
              transactionP.initializePayStack(
                transactionP.initializeRefRES.data!.accessCode,
                authProvider.user.email,
                context,
              );
            },
          ),
        ],
      ),
    );
  }
}
