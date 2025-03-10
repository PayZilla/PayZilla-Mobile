import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

// TODO(Taiwo) => check if i was navigated here from topup, paybills or direct
// this is so that when i click on the card, i can decide on what to do with card

class MyCardScreen extends StatefulWidget {
  const MyCardScreen({super.key});

  @override
  State<MyCardScreen> createState() => _MyCardScreenState();
}

class _MyCardScreenState extends State<MyCardScreen> {
  List<CardsModel> selectedCard = [];

  @override
  Widget build(BuildContext context) {
    final cardProvider = context.read<MyCardsProvider>();
    final transactionP = context.watch<TransactionProvider>();

    return AppScaffold(
      useBodyPadding: false,
      appBar: CustomAppBar(
        centerTitle: true,
        leading: const SizedBox.shrink(),
        titleWidget: Text(
          'My Card',
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
            if (transactionP.cardsServiceResponse.isLoading)
              const Expanded(
                child: Center(
                  child: TempLoadingAtmCard(
                    color: AppColors.textHeaderColor,
                  ),
                ),
              ),
            if (transactionP.cardsServiceResponse.isSuccess)
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const YBox(Insets.dim_24),
                  itemCount: transactionP.cardsServiceResponse.data!.length,
                  itemBuilder: (context, index) {
                    final data = transactionP.cardsServiceResponse.data![index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          data.selected = !data.selected;
                          if (data.selected) {
                            selectedCard.add(data.value);
                          } else {
                            selectedCard.remove(data.value);
                          }
                        });
                      },
                      child: MyCardsWidget(
                        card: data.value,
                        cardLogo: transactionP.buildLogo(data.value.cardType),
                        color: data.selected
                            ? AppColors.borderErrorColor
                            : cardProvider.cardColor(data.value.cardType),
                      ),
                    );
                  },
                ),
              ),
            if (transactionP.deleteCardRES.isLoading)
              const AppCircularLoadingWidget()
            else if (transactionP.accountDetailsRES.isError)
              AppSolidButton(
                textTitle: 'Update KYC',
                action: () {
                  AppNavigator.of(context).push(AppRoutes.country);
                },
              )
            else
              InkWell(
                onTap: () async {
                  if (selectedCard.isEmpty) {
                    AppNavigator.of(context).push(AppRoutes.startCreateCard);
                  } else {
                    for (final card in selectedCard) {
                      await transactionP.deleteCard(card.id, context);
                      selectedCard = [];
                    }
                  }
                },
                child: Container(
                  height: context.getHeight(0.07),
                  decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    borderRadius: Corners.mdBorder,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        selectedCard.isEmpty ? Icons.add : Icons.delete_forever,
                        color: selectedCard.isEmpty
                            ? AppColors.textHeaderColor
                            : AppColors.borderErrorColor,
                        size: Insets.dim_40,
                      ),
                      const XBox(Insets.dim_12),
                      Text(
                        selectedCard.isEmpty ? 'Add new card' : 'Delete card',
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: selectedCard.isEmpty
                              ? AppColors.textHeaderColor
                              : AppColors.borderErrorColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          letterSpacing: 0.30,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            const YBox(Insets.dim_24),
          ],
        ),
      ),
    );
  }
}
