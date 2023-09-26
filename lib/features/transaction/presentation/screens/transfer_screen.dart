import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/analytics/analytics.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  int? currentSelectedIndex;
  @override
  Widget build(BuildContext context) {
    final cardProvider = context.read<MyCardsProvider>();
    final analyticProvider = context.watch<AnalyticProvider>();

    return AppScaffold(
      useBodyPadding: false,
      appBar: CustomAppBar(
        centerTitle: true,
        leading: AppBoxedButton(
          onPressed: () => AppNavigator.of(context).pop(),
        ),
        titleWidget: Text(
          'Transfer',
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
        child: ListView(
          children: [
            const YBox(Insets.dim_24),
            Text(
              'Choose cards',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.btnPrimaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: 0.30,
              ),
            ),
            const YBox(Insets.dim_16),
            /*
            SizedBox(
              height: context.getHeight(0.25),
              child: PageView.builder(
                onPageChanged: analyticProvider.onSliderChange,
                controller: analyticProvider.pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: cardProvider.screens.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: Insets.dim_16),
                  child: GestureDetector(
                    onTap: () => AppNavigator.of(context).push(
                      AppRoutes.editCardFromMyCardScreen,
                      args: EditCardScreenArgs(
                        card: cardProvider.screens[index],
                        cardPrimaryColor: cardProvider.cardColors[index],
                      ),
                    ),
                    child: cardProvider.screens[index],
                  ),
                ),
              ),
            ),
            const YBox(Insets.dim_12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                cardProvider.screens.length,
                (index) => buildDot(
                  index: index,
                  currentPage: analyticProvider.currentSliderIndex,
                ),
              ),
            ),*/
            const YBox(Insets.dim_24),
            Text(
              'Choose recipients',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.btnPrimaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: 0.30,
              ),
            ),
            const YBox(Insets.dim_16),
            const SearchTextInputField(
              showTrailing: false,
              title: 'Search contacts',
            ),
            const YBox(Insets.dim_24),
            SizedBox(
              height: context.getHeight(0.22),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const XBox(Insets.dim_14),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => setState(() => currentSelectedIndex = index),
                    child: SelectableContactWidget(
                      index: index,
                      isSelected: currentSelectedIndex == index,
                    ),
                  );
                },
              ),
            ),
            const YBox(Insets.dim_32),
            AppButton(
              textTitle: 'Continue',
              action: () {
                AppNavigator.of(context).push(
                  AppRoutes.sendMoney,
                  args: const SendMoneyScreenArgs(
                    name: 'John O. Williams',
                    url: 'https://picsum.photos/200/300',
                  ),
                );
              },
            ),
            const YBox(Insets.dim_32),
          ],
        ),
      ),
    );
  }
}
