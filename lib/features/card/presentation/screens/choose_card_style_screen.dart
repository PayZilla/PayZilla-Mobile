import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class ChooseCardStyleScreen extends StatelessWidget {
  const ChooseCardStyleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cardProvider = context.read<MyCardsProvider>();
    return AppScaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: Insets.dim_24),
          child: AppBoxedButton(),
        ),
        leadingWidth: 80,
        titleWidget: Text(
          'Choose your style',
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 0.30,
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: cardProvider.screens.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => AppNavigator.of(context).push(
            AppRoutes.editCardScreen,
            args: EditCardScreenArgs(
              card: cardProvider.screens[index],
              cardPrimaryColor: cardProvider.cardColors[index],
            ),
          ),
          child: cardProvider.screens[index],
        ),
        separatorBuilder: (context, index) => const YBox(Insets.dim_24),
      ),
    );
  }
}
