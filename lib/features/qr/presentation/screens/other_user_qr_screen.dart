import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OtherUserQrScreenArgs {
  OtherUserQrScreenArgs(this.qrValue, this.paymentId);

  final WalletOrBankModel qrValue;
  final String paymentId;
}

class OtherUserQrScreen extends StatefulWidget {
  const OtherUserQrScreen({super.key, required this.args});

  final OtherUserQrScreenArgs args;

  @override
  State<OtherUserQrScreen> createState() => _OtherUserQrScreenState();
}

class _OtherUserQrScreenState extends State<OtherUserQrScreen> {
  bool _showOptions = false;
  double _width = 0;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendedBody: true,
      appBar: CustomAppBar(
        centerTitle: true,
        appBarTitleColor: AppColors.textHeaderColor,
        title: 'Send Money',
        leading: AppBoxedButton(
          onPressed: () => AppNavigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: Insets.dim_12,
              horizontal: Insets.dim_12,
            ),
            tileColor: AppColors.borderColor,
            shape: const RoundedRectangleBorder(
              borderRadius: Corners.mdBorder,
            ),
            leading: HostedImage(
              widget.args.qrValue.avatarUrl,
              height: 50,
              width: 50,
              fit: BoxFit.contain,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.args.qrValue.name,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textHeaderColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const YBox(Insets.dim_4),
                Row(
                  children: [
                    Text(
                      widget.args.qrValue.accountNumber,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textHeaderColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    const XBox(Insets.dim_4),
                    Text(
                      '-- (${widget.args.qrValue.bankName})',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textHeaderColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
            trailing: InkWell(
              onTap: () => setState(() {
                _showOptions = !_showOptions;
                if (_showOptions) {
                  _width = context.getWidth();
                } else {
                  _width = 0;
                }
              }),
              child: Icon(
                _showOptions
                    ? Icons.keyboard_arrow_up_outlined
                    : Icons.keyboard_arrow_down_outlined,
                color: AppColors.black.withOpacity(0.6),
                size: Insets.dim_24,
              ),
            ),
          ),
          if (_showOptions) const YBox(Insets.dim_2),
          AnimatedContainer(
            duration: 1.seconds,
            width: _width,
            curve: Curves.easeInToLinear,
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.dim_24,
              vertical: Insets.dim_12,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Corners.mdRadius,
                bottomRight: Corners.mdRadius,
              ),
              color: AppColors.black.withOpacity(0.05),
            ),
            child: _showOptions
                ? Row(
                    children: [
                      Expanded(
                        child: AppSolidButton(
                          textTitle: 'Wallet',
                          action: () {
                            AppNavigator.of(context).push(
                              AppRoutes.sendMoney,
                              args: SendMoneyScreenArgs(
                                contact: widget.args.qrValue,
                                paymentId: widget.args.paymentId,
                              ),
                            );
                          },
                          backgroundColor: AppColors.appSecondaryColor,
                        ),
                      ),
                      const XBox(Insets.dim_12),
                      Expanded(
                        child: AppSolidButton(textTitle: 'Bank', action: () {}),
                      ),
                    ],
                  )
                : null,
          ),
          const YBox(Insets.dim_44),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: Corners.mdBorder,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textBodyColor.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 0.2,
                    offset: const Offset(-5, 10),
                  )
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(Insets.dim_40),
                decoration: const BoxDecoration(
                  borderRadius: Corners.mdBorder,
                  color: AppColors.white,
                ),
                child: QrImageView(
                  data: widget.args.qrValue.accountNumber,
                  size: context.getHeight(.3),
                  backgroundColor: AppColors.white,
                ),
              ),
            ),
          ),
          const Spacer(),
          const Icon(
            PhosphorIcons.warningCircleBold,
            color: AppColors.black,
          ),
          const YBox(Insets.dim_24),
          Text(
            'This is a single-use code for your use only. Get a new code each time you pay with PayZilla',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textHeaderColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
