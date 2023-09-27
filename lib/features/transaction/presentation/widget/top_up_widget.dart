import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class TopUpArgs {
  TopUpArgs(this.cardsModel);

  final CardsModel cardsModel;
}

class TopUpWidget extends StatefulWidget {
  const TopUpWidget({super.key, required this.args});
  final TopUpArgs args;

  @override
  State<TopUpWidget> createState() => _TopUpWidgetState();
}

class _TopUpWidgetState extends State<TopUpWidget> with FormMixin {
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final money = context.money();
    final transactionP = context.watch<TransactionProvider>();
    final authP = context.watch<AuthProvider>();
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
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const YBox(Insets.dim_40),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: Corners.smBorder,
                  color: AppColors.borderColor,
                  border: Border.all(
                    color: AppColors.black.withOpacity(0.6),
                  ),
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Text(
                        widget.args.cardsModel.accountName,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: AppColors.textHeaderColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          letterSpacing: 0.30,
                        ),
                      ),
                      const XBox(Insets.dim_12),
                      Text(
                        '**** **** **** ${widget.args.cardsModel.last4}',
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: AppColors.textBodyColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          letterSpacing: 0.30,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    widget.args.cardsModel.bank,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.textBodyColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: 0.30,
                    ),
                  ),
                ),
              ),
              const YBox(Insets.dim_24),
              SpecialAmountTextField(
                controller: amountController,
                onSaved: (value) => amountController.text = value ?? '',
                validator: (input) => Validators.validateAmount()(input),
              ),
              const YBox(Insets.dim_12),
              SizedBox(
                height: 40,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: transactionP.sampleAmount
                        .map(
                          (e) => FittedBox(
                            child: CustomWidget(
                              onSelect: () {
                                setState(() {
                                  amountController.text = e;
                                });
                              },
                              amount: money.formatValue(e.toInt() * 100),
                              isSelected: amountController.text == e,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              const YBox(Insets.dim_60),
              AppSolidButton(
                textTitle: 'Continue',
                action: () {
                  validate(() {
                    transactionP.initializePayStack(
                      widget.args.cardsModel.id,
                      authP.user.email,
                      context,
                      amount: amountController.text.toInt(),
                      topUp: true,
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
