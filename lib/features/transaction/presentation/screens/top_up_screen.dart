import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/qr/qr.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class FundingAccountDetails extends StatefulWidget {
  const FundingAccountDetails({super.key});

  @override
  State<FundingAccountDetails> createState() => _FundingAccountDetailsState();
}

class _FundingAccountDetailsState extends State<FundingAccountDetails> {
  ScrollController controller = ScrollController();
  late TransactionProvider transactionP;
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => transactionP
        ..getAccounts()
        ..getCards(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    transactionP = context.watch<TransactionProvider>();
    final cardsProvider = context.read<MyCardsProvider>();
    return AppScaffold(
      useBodyPadding: false,
      appBar: CustomAppBar(
        centerTitle: true,
        titleWidget: Text(
          'Top up',
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 0.30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.dim_22),
        child: Column(
          children: [
            const YBox(Insets.dim_20),
            Container(
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.symmetric(
                horizontal: Insets.dim_22,
                vertical: Insets.dim_12,
              ),
              decoration: BoxDecoration(
                borderRadius: Corners.mdBorder,
                color: AppColors.borderColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.2),
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: LocalSvgImage(bankSvg),
                    title: Text(
                      'Bank Details',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textHeaderColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        letterSpacing: 0.30,
                      ),
                    ),
                    subtitle: Text(
                      'Top up via bank transfer (Internet or Mobile banking)',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textBodyColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: 0.30,
                      ),
                    ),
                  ),
                  const YBox(Insets.dim_12),
                  const Divider(),
                  const YBox(Insets.dim_12),
                  if (transactionP.accountDetailsRES.isSuccess) ...[
                    Text(
                      transactionP.accountDetailsRES.data!.name,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textHeaderColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        letterSpacing: 0.30,
                      ),
                    ),
                    SizedBox(
                      height: context.getHeight(0.15),
                      child: Scrollbar(
                        controller: controller,
                        thumbVisibility: true,
                        radius: const Radius.circular(Insets.dim_12),
                        child: ListView.builder(
                          controller: controller,
                          itemCount:
                              transactionP.accountDetailsRES.data!.banks.length,
                          itemBuilder: (context, index) {
                            final data = transactionP
                                .accountDetailsRES.data!.banks[index];
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: Insets.dim_24,
                                horizontal: Insets.dim_16,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    PhosphorIcons.copy,
                                    size: Insets.dim_24,
                                    color: AppColors.textBodyColor,
                                  ).onTap(
                                    () => data.toJson().toString().toClipboard(
                                          feedbackMsg:
                                              '${data.bankName} details copied to clipboard',
                                        ),
                                  ),
                                  const XBox(Insets.dim_14),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.bankName,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textBodyColor,
                                        ),
                                      ),
                                      const YBox(Insets.dim_4),
                                      Text(
                                        data.accountNumber,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textBodyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Text(
                                    'Share',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.black,
                                    ),
                                  ).onTap(
                                    () async {
                                      await shareAccountDetails(
                                        data,
                                        transactionP
                                            .accountDetailsRES.data!.name,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const YBox(Insets.dim_20),
            Row(
              children: const [
                Expanded(child: Divider(thickness: 2)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Insets.dim_12),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textBodyColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Expanded(child: Divider(thickness: 2)),
              ],
            ),
            const YBox(Insets.dim_20),
            ListTile(
              onTap: () async {
                if (transactionP.cardsServiceResponse.data != null &&
                    transactionP.cardsServiceResponse.data!.isNotEmpty) {
                  await FutureBottomSheet<CardsModel>(
                    title: 'Select an option',
                    height: context.getHeight(0.56),
                    future: () async => transactionP.cardsServiceResponse.data!,
                    itemBuilder: (context, card) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Insets.dim_20,
                        ),
                        child: MyCardsWidget(
                          card: card,
                          color: cardsProvider.cardColor(card.cardType),
                        ),
                      );
                    },
                  ).show(context).then((value) {
                    if (value != null) {
                      AppNavigator.of(context).push(
                        AppRoutes.topUpAmountScreen,
                        args: TopUpArgs(value as CardsModel),
                      );
                    }
                  });
                } else {
                  AppNavigator.of(context).push(AppRoutes.myCard);
                }
              },
              leading: LocalSvgImage(bankSvg),
              title: Text(
                'Top up via card',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.textHeaderColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  letterSpacing: 0.30,
                ),
              ),
              subtitle: Text(
                'Directly top up via card ',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.textBodyColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  letterSpacing: 0.30,
                ),
              ),
              trailing: transactionP.cardsServiceResponse.isLoading
                  ? const SizedBox(
                      height: 30,
                      width: 30,
                      child: AppCircularLoadingWidget(),
                    )
                  : const Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
            ),
            const YBox(Insets.dim_20),
            ListTile(
              leading: LocalSvgImage(bankSvg),
              onTap: () {
                AppNavigator.of(context).push(
                  AppRoutes.qrScan,
                  args: QRScreenArgs(authProvider.user.phoneNumber),
                );
              },
              title: Text(
                'Scan QR Code',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.textHeaderColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  letterSpacing: 0.30,
                ),
              ),
              subtitle: Text(
                'Top up via PayZilla account',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.textBodyColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  letterSpacing: 0.30,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> shareAccountDetails(Banks data, String accountName) async {
    await Share.share(
      'PayZilla account details: \n${data.bankName}\n ${data.accountNumber}\n$accountName',
    );
  }
}
