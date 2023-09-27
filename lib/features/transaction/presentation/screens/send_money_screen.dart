import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class SendMoneyScreenArgs {
  const SendMoneyScreenArgs({
    required this.contact,
  });

  final ContactsModel contact;
}

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key, required this.args});

  final SendMoneyScreenArgs args;

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> with FormMixin {
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final money = context.money();

    return AppScaffold(
      useBodyPadding: false,
      appBar: CustomAppBar(
        centerTitle: true,
        leading: AppBoxedButton(
          onPressed: () => AppNavigator.of(context).pop(),
        ),
        titleWidget: Text(
          'Send Money',
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 0.30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.dim_22),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const YBox(Insets.dim_32),
                Container(
                  padding: const EdgeInsets.all(Insets.dim_12),
                  height: context.getHeight(0.15),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                    border: Border.all(width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.textBodyColor.withOpacity(0.05),
                        blurRadius: 10,
                        spreadRadius: 10,
                      )
                    ],
                  ),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: HostedImage(
                      widget.args.contact.avatar,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                const YBox(Insets.dim_12),
                Center(
                  child: Text(
                    'to ${widget.args.contact.name}',
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.textHeaderColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      letterSpacing: 0.30,
                    ),
                  ),
                ),
                const YBox(Insets.dim_16),
                SpecialAmountTextField(
                  controller: amountController,
                  onSaved: (value) => amountController.text = value ?? '',
                  validator: (input) => Validators.validateAmount()(input),
                ),
                YBox(context.getHeight(0.4)),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AppButton(
                    textTitle: 'Send Money',
                    action: () {
                      validate(() {
                        showDialog(
                          context: context,
                          builder: (context) => CustomDialogBox(
                            descriptions: '',
                            contact: widget.args.contact,
                            amount: amountController.text,
                            img: widget.args.contact.avatar,
                            text: 'Send ${money.formatValue(
                              amountController.text.toInt(),
                            )} to ${widget.args.contact.name}',
                          ),
                        ).then(
                          (value) {
                            if (value != null) {
                              Future.delayed(3.seconds).then((value) {
                                AppNavigator.of(context).push(
                                  AppRoutes.successfulTransaction,
                                  args: TransactionSuccessArgs(
                                    'Transfer Successful',
                                    money.formatValue(
                                      amountController.text.toInt(),
                                    ),
                                  ),
                                );
                              });
                            }
                          },
                        );
                      });
                    },
                  ),
                ),
                const YBox(Insets.dim_32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
