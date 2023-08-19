import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/analytics/analytics.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class SendMoneyScreenArgs {
  const SendMoneyScreenArgs({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;
}

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key, required this.args});

  final SendMoneyScreenArgs args;

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  int? currentSelectedIndex;
  @override
  Widget build(BuildContext context) {
    final money = context.money();

    return AppScaffold(
      useBodyPadding: false,
      appBar: CustomAppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: Insets.dim_24),
          child: AppBoxedButton(
            onPressed: () => AppNavigator.of(context).pop(),
          ),
        ),
        leadingWidth: 80,
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
                  child: const LocalImage(
                    selfie,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const YBox(Insets.dim_12),
              Center(
                child: Text(
                  'to ${widget.args.name}',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textHeaderColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    letterSpacing: 0.30,
                  ),
                ),
              ),
              const YBox(Insets.dim_16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: Corners.mdBorder,
                  border: Border.all(
                    color: const Color(0xffE5E7EB),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: Insets.dim_16,
                  vertical: Insets.dim_16,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Enter amount:',
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: AppColors.textBodyColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.30,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Max ${money.formatValue(6450000)}',
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: AppColors.textHeaderColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ),
                    const YBox(Insets.dim_16),
                    IgnorePointer(
                      ignoring: false,
                      child: PhoneNumberTextFormField(
                        hintText: '00.00',
                        prefixIcon: SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: Insets.dim_16,
                                  right: Insets.dim_6,
                                ),
                                child: Text(
                                  'NG',
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.textHeaderColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: 0.1,
                                  ),
                                ),
                              ),
                              const Icon(
                                PhosphorIcons.caretDown,
                                size: 18,
                                color: AppColors.btnPrimaryColor,
                              ),
                              const XBox(Insets.dim_26),
                            ],
                          ),
                        ).onTap(() async {
                          final country = await FutureBottomSheet<CountryData>(
                            title: 'Select country',
                            future: () async =>
                                [phoneNumberCountryList().first],
                            itemBuilder: (context, item) {
                              return ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: LocalSvgImage(item.flag),
                                ),
                                title: Text(
                                  '(${item.currencyCode}) ${item.countryName}',
                                ),
                              );
                            },
                          ).show(context);
                          if (country != null) {
                            setState(() {});
                          }
                        }),
                        onSaved: (phoneNumber) {},
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: AppColors.textHeaderColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              YBox(context.getHeight(0.4)),
              Align(
                alignment: Alignment.bottomCenter,
                child: AppButton(
                  textTitle: 'Send Money',
                  action: () {
                    showDialog(
                      context: context,
                      builder: (context) => const CustomDialogBox(),
                    ).then(
                      (value) {
                        if (value) {
                          AppNavigator.of(context).push(
                            AppRoutes.successfulTransaction,
                            args: TransactionSuccessArgs(
                              'Transfer Successful',
                              money.formatValue(8650000),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              const YBox(Insets.dim_32),
            ],
          ),
        ),
      ),
    );
  }
}
