import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class CardDetailScreenArgs {
  const CardDetailScreenArgs({
    required this.card,
  });
  final dynamic card;
}

class CardDetailScreen extends StatefulWidget {
  const CardDetailScreen({super.key, required this.args});
  final CardDetailScreenArgs args;

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final cardProvider = context.read<MyCardsProvider>();
    Log().debug('', widget.args.card);
    return DefaultTabController(
      length: 3,
      child: AppScaffold(
        useBodyPadding: false,
        appBar: CustomAppBar(
          centerTitle: true,
          leading: const AppBoxedButton(),
          titleWidget: Text(
            'Card Details',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              letterSpacing: 0.30,
            ),
          ),
        ),
        body: Container(
          height: context.getHeight(),
          width: context.getWidth(),
          padding: const EdgeInsets.symmetric(horizontal: Insets.dim_24),
          color: AppColors.grey,
          child: Column(
            children: [
              const YBox(Insets.dim_44),
              MyCardsWidget(
                card: widget.args.card,
                color: cardProvider.cardColor(widget.args.card.cardType),
              ),
              const YBox(Insets.dim_44),
              const Spacer(),
              AppButton(
                textTitle: 'Delete Card',
                action: () {},
                backgroundColor: AppColors.borderErrorColor.withOpacity(0.4),
                color: AppColors.textHeaderColor,
              ),
              const YBox(Insets.dim_40),
            ],
          ),
        ),
      ),
    );
  }
}
