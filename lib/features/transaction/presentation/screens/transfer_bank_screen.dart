import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class BankTransferScreen extends StatefulWidget {
  const BankTransferScreen({super.key});

  @override
  State<BankTransferScreen> createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends State<BankTransferScreen>
    with FormMixin {
  late TransactionProvider transactionP;
  BanksModel? _selectedValue;
  final amountController = TextEditingController();

  ValidateBankOrWalletDto requestDto = ValidateBankOrWalletDto.empty();
  BankChannel bankChannelDto = BankChannel.empty();
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => transactionP.getBanks(),
    );
    requestDto = requestDto.copyWith(channel: Channel.bank);
  }

  @override
  Widget build(BuildContext context) {
    transactionP = context.watch<TransactionProvider>();
    final money = context.money();
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
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const YBox(Insets.dim_24),
              Text(
                'Wallet balance',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.btnPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  letterSpacing: 0.30,
                ),
              ),
              const YBox(Insets.dim_16),
              const TransferWalletCard(),
              const YBox(Insets.dim_40),
              AppDropDownField(
                labelText: 'Bank',
                initialValue: bankChannelDto.bankCode,
                textFieldIcon: transactionP.banksServiceResponse.isLoading
                    ? Row(
                        children: const [
                          Spacer(),
                          AppCircularLoadingWidget(color: AppColors.black),
                          XBox(Insets.dim_12),
                        ],
                      )
                    : null,
                validator: (input) => input != null
                    ? Validators.validateString()((input as BanksModel).name)
                    : null,
                items: transactionP.banksServiceResponse.data ?? [],
                value: _selectedValue,
                onChanged: (value) {
                  setState(() => _selectedValue = value as BanksModel);
                  bankChannelDto = bankChannelDto.copyWith(
                    bankCode: (value as BanksModel).code,
                  );
                },
              ),
              const YBox(Insets.dim_24),
              AppTextFormField(
                labelText: 'Account Number',
                initialValue: bankChannelDto.accountNumber,
                hintText: 'Enter account number',
                validator: (input) => Validators.validateString()(input),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                onChanged: (input) {
                  if (input.isNotEmpty && input.length == 10) {
                    // validate account number
                    bankChannelDto =
                        bankChannelDto.copyWith(accountNumber: input);
                    requestDto =
                        requestDto.copyWith(bankChannel: bankChannelDto);
                    transactionP.validateBanksOrWallet(requestDto);
                  }
                },
              ),
              if (transactionP.valBanksOrWalletResponse.isLoading) ...[
                const YBox(Insets.dim_4),
                Row(
                  children: const [
                    Spacer(),
                    AppCircularLoadingWidget(
                      color: AppColors.textHeaderColor,
                    ),
                  ],
                ),
              ],
              if (transactionP.valBanksOrWalletResponse.isSuccess) ...[
                const YBox(Insets.dim_4),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      transactionP.valBanksOrWalletResponse.data!.name,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textHeaderColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: 0.30,
                      ),
                    ),
                  ],
                ),
              ],
              const YBox(Insets.dim_16),
              AppTextFormField(
                hintText: '00.00',
                labelText: 'Amount',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                inputType: TextInputType.number,
                validator: (input) => Validators.validateAmount()(input),
                onSaved: (value) {
                  requestDto = requestDto.copyWith(amount: value?.toInt());
                  amountController.text = value ?? '';
                },
                controller: amountController,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.textHeaderColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  letterSpacing: 0.1,
                ),
              ),
              const YBox(Insets.dim_24),
              AppTextFormField(
                initialValue: requestDto.description,
                hintText: 'Enter description',
                labelText: 'Description',
                isLoading: transactionP.transBanksOrWalletResponse.isLoading,
                inputType: TextInputType.text,
                onSaved: (value) {
                  requestDto = requestDto.copyWith(description: value);
                },
                validator: (input) => Validators.validateString()(input),
              ),
              YBox(context.getHeight(0.2)),
              AppButton(
                textTitle: 'Send Money',
                showLoading: transactionP.transBanksOrWalletResponse.isLoading,
                action: () {
                  validate(() {
                    showDialog(
                      context: context,
                      builder: (context) => CustomDialogBox(
                        descriptions: '',
                        contact: transactionP.valBanksOrWalletResponse.data!,
                        amount: amountController.text,
                        img: transactionP
                            .valBanksOrWalletResponse.data!.avatarUrl,
                        text: 'Send ${money.formatValue(
                          amountController.text.toInt(),
                        )} to ${transactionP.valBanksOrWalletResponse.data!.name}',
                      ),
                    ).then(
                      (value) {
                        if (value != null) {
                          requestDto = requestDto.copyWith(transactionPin: '');
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
                              transactionP
                                  .transferBanksOrWallet(requestDto)
                                  .then((value) {
                                if (transactionP
                                    .transBanksOrWalletResponse.isSuccess) {
                                  AppNavigator.of(context).push(
                                    AppRoutes.successfulTransaction,
                                    args: TransactionSuccessArgs(
                                      transactionP
                                          .valBanksOrWalletResponse.data!.name,
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
            ],
          ),
        ),
      ),
    );
  }
}
