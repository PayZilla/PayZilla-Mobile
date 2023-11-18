import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/extensions/context_extension.dart';
import 'package:pay_zilla/functional_utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    final transactionsProvider = context.watch<TransactionHistoryProvider>();

    return DefaultTabController(
      length: 4,
      child: AppScaffold(
        useBodyPadding: false,
        appBar: CustomAppBar(
          centerTitle: true,
          leading: const SizedBox.shrink(),
          titleWidget: Text(
            'Activity',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              letterSpacing: 0.30,
            ),
          ),
          bottom: transactionsProvider.getTransactionsResponse.isLoading
              ? const PreferredSize(
                  preferredSize: Size.fromHeight(80),
                  child: AppLinearLoadingWidget(),
                )
              : null,
        ),
        body: RefreshIndicator(
          backgroundColor: AppColors.textHeaderColor,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async {
            transactionsProvider.fetchMore(
                transactionsProvider.pageNumCount, context);
          },
          child: ListView(
            controller: transactionsProvider.controller,
            children: [
              SizedBox(
                height: context.getHeight(0.8),
                child: const TransactionList(useRefresh: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
