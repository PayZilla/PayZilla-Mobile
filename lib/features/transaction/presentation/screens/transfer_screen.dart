import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/qr/qr.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> with FormMixin {
  int? currentSelectedIndex;
  ValidateBankOrWalletDto requestDto = ValidateBankOrWalletDto.empty();
  WalletChannel walletChannelDto = WalletChannel.empty();
  late ProfileProvider profileProvider;
  bool _showButton = false;
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => profileProvider
        ..searchedContacts = []
        ..fetchedContacts = []
        ..fetchContacts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    profileProvider = context.watch<ProfileProvider>();
    final transProvider = context.watch<TransactionProvider>();

    return Stack(
      children: [
        AppScaffold(
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
                  const YBox(Insets.dim_24),
                  PhoneNumberTextFormField(
                    initialValue: requestDto.walletChannel.paymentId,
                    hintText: 'Enter payment ID',
                    onChanged: (input) {
                      if (input.isNotEmpty && input.length == 11) {
                        setState(() => _showButton = true);
                      } else {
                        setState(() => _showButton = false);
                      }
                    },
                    onSaved: (value) {
                      requestDto = requestDto.copyWith(
                        walletChannel: WalletChannel(
                          paymentId: '234${value!.substring(1)}',
                        ),
                      );
                    },
                    textFieldIcon: GestureDetector(
                      onTap: () => AppNavigator.of(context).push(
                        AppRoutes.scanQrScreen,
                        args: ScanQrScreenArgs(isSendMoney: true),
                      ),
                      child: const Icon(Icons.qr_code_scanner_rounded),
                    ),
                  ),
                  const YBox(Insets.dim_24),
                  Text(
                    'Choose from contact',
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.btnPrimaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      letterSpacing: 0.30,
                    ),
                  ),
                  const YBox(Insets.dim_16),
                  SearchTextInputField(
                    showTrailing: false,
                    title: 'Search contacts',
                    onChanged: (value) {
                      if (value.isNotEmpty &&
                          profileProvider.fetchedContacts != null) {
                        profileProvider.searchedContacts =
                            profileProvider.fetchedContacts!
                                .where(
                                  (contact) => contact.displayName
                                      .toLowerCase()
                                      .contains(value.toLowerCase()),
                                )
                                .toList();
                      } else {
                        profileProvider.searchedContacts =
                            profileProvider.fetchedContacts;
                      }
                      setState(() {});
                    },
                  ),
                  const YBox(Insets.dim_24),
                  if (profileProvider.searchedContacts != null &&
                      profileProvider.searchedContacts!.isNotEmpty)
                    SizedBox(
                      height: context.getHeight(0.22),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            const XBox(Insets.dim_14),
                        itemCount: profileProvider.searchedContacts!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (transProvider
                                  .valBanksOrWalletResponse.isLoading) {
                                return;
                              }
                              setState(() => currentSelectedIndex = index);
                              if (profileProvider
                                  .searchedContacts![index].phones.isNotEmpty) {
                                requestDto = requestDto.copyWith(
                                  channel: Channel.wallet,
                                  walletChannel: WalletChannel(
                                    paymentId: Validators.harmonizeForContacts(
                                      profileProvider.searchedContacts![index]
                                          .phones.first.number,
                                    ),
                                  ),
                                );

                                await transProvider.validateBanksOrWallet(
                                    requestDto, context);
                                if (transProvider
                                    .valBanksOrWalletResponse.isSuccess) {
                                  // ignore: use_build_context_synchronously
                                  AppNavigator.of(context).push(
                                    AppRoutes.sendMoney,
                                    args: SendMoneyScreenArgs(
                                      contact: transProvider
                                          .valBanksOrWalletResponse.data!,
                                      paymentId:
                                          requestDto.walletChannel.paymentId,
                                    ),
                                  );
                                }
                              } else {
                                showInfoNotification(
                                    context, 'No phone number');
                              }
                            },
                            child: SelectableContactWidget(
                              index: index,
                              isSelected: currentSelectedIndex == index,
                              contact: profileProvider.searchedContacts![index],
                            ),
                          );
                        },
                      ),
                    ),
                  if (profileProvider.loading)
                    const AppCircularLoadingWidget(color: AppColors.black),
                  const YBox(Insets.dim_32),
                  if (_showButton) ...[
                    AppButton(
                      textTitle: 'Send Money',
                      showLoading:
                          transProvider.transBanksOrWalletResponse.isLoading,
                      action: () {
                        validate(() {
                          requestDto = requestDto.copyWith(
                            channel: Channel.wallet,
                          );
                          transProvider
                              .validateBanksOrWallet(requestDto, context)
                              .then((value) {
                            if (transProvider
                                .valBanksOrWalletResponse.isSuccess) {
                              AppNavigator.of(context).push(
                                AppRoutes.sendMoney,
                                args: SendMoneyScreenArgs(
                                  contact: transProvider
                                      .valBanksOrWalletResponse.data!,
                                  paymentId: requestDto.walletChannel.paymentId,
                                ),
                              );
                            }
                          });
                        });
                      },
                    ),
                    const YBox(Insets.dim_32),
                  ]
                ],
              ),
            ),
          ),
        ),
        if (transProvider.valBanksOrWalletResponse.isLoading)
          Container(
            color: AppColors.black.withOpacity(0.5),
            child: const AppCircularLoadingWidget(
              color: AppColors.white,
              size: Insets.dim_30,
            ),
          ),
      ],
    );
  }
}
