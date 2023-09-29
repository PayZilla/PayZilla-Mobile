import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class SendMoneyScreenArgs {
  const SendMoneyScreenArgs({
    this.contact,
    this.paymentId,
  });

  final WalletOrBankModel? contact;
  final String? paymentId;
}

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key, required this.args});

  final SendMoneyScreenArgs args;

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> with FormMixin {
  final amountController = TextEditingController();
  ValidateBankOrWalletDto requestDto = ValidateBankOrWalletDto.empty();
  WalletChannel walletChannelDto = WalletChannel.empty();
  BankChannel bankChannelDto = BankChannel.empty();
  late WalletOrBankModel contact;
  bool _walletSelected = false;
  @override
  void initState() {
    super.initState();
    contact = widget.args.contact ?? WalletOrBankModel.empty();
    _walletSelected = contact.avatarUrl.isNotEmpty;
    // this is we sending to wallet
    if (_walletSelected) {
      requestDto = requestDto.copyWith(
        walletChannel: walletChannelDto = walletChannelDto.copyWith(
          paymentId: widget.args.paymentId,
        ),
      );
    }
    requestDto = requestDto.copyWith(
      channel: _walletSelected ? Channel.wallet : Channel.bank,
    );
  }

  @override
  Widget build(BuildContext context) {
    final money = context.money();
    final transferP = context.watch<TransactionProvider>();
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
                      contact.avatarUrl,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                const YBox(Insets.dim_12),
                Center(
                  child: Text(
                    'to ${contact.name}',
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
                  onSaved: (value) {
                    requestDto = requestDto.copyWith(amount: value?.toInt());
                    amountController.text = value ?? '';
                  },
                  validator: (input) => Validators.validateAmount()(input),
                ),
                const YBox(Insets.dim_12),
                AppTextFormField(
                  initialValue: requestDto.description,
                  hintText: 'Enter description',
                  isLoading: transferP.transBanksOrWalletResponse.isLoading,
                  inputType: TextInputType.text,
                  onSaved: (value) {
                    requestDto = requestDto.copyWith(description: value);
                  },
                  validator: (input) => Validators.validateString()(input),
                ),
                YBox(context.getHeight(0.4)),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AppButton(
                    textTitle: 'Send Money',
                    showLoading: transferP.transBanksOrWalletResponse.isLoading,
                    action: () {
                      validate(() {
                        showDialog(
                          context: context,
                          builder: (context) => CustomDialogBox(
                            descriptions: '',
                            contact: contact,
                            amount: amountController.text,
                            img: contact.avatarUrl,
                            text: 'Send ${money.formatValue(
                              amountController.text.toInt(),
                            )} to ${contact.name}',
                          ),
                        ).then(
                          (value) {
                            if (value != null) {
                              requestDto =
                                  requestDto.copyWith(transactionPin: '');
                              FutureBottomSheet<Widget>(
                                title: 'Enter PIN',
                                height: context.getHeight(0.3),
                                future: () async => [
                                  PinTextField(
                                    validator: (input) =>
                                        Validators.validateString()(input),
                                    onSaved: (input) {
                                      requestDto = requestDto.copyWith(
                                        transactionPin: input,
                                      );
                                    },
                                  ),
                                  const YBox(Insets.dim_16),
                                  AppSolidButton(
                                    textTitle: 'Confirm',
                                    action: () {
                                      if (requestDto.transactionPin.isEmpty) {
                                        showInfoNotification('Enter valid PIN');
                                      } else {
                                        Navigator.pop(context, true);
                                      }
                                    },
                                  )
                                ],
                                itemBuilder: (context, item) {
                                  return item;
                                },
                              ).show(context).then((value) {
                                if (value != null) {
                                  transferP
                                      .transferBanksOrWallet(requestDto)
                                      .then((value) {
                                    if (transferP
                                        .transBanksOrWalletResponse.isSuccess) {
                                      AppNavigator.of(context).push(
                                        AppRoutes.successfulTransaction,
                                        args: TransactionSuccessArgs(
                                          contact.name,
                                          money.formatValue(
                                            requestDto.amount *
                                                100, //Note: convert to Naira from Kobo
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                }
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
