import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/qr/qr.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrShowScreenArgs {
  QrShowScreenArgs(this.qrValue);

  final TransferValidateModel qrValue;
}

class QrShowScreen extends StatelessWidget {
  const QrShowScreen({super.key, required this.args});

  final QrShowScreenArgs args;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendedBody: true,
      appBar: CustomAppBar(
        centerTitle: true,
        appBarTitleColor: AppColors.textHeaderColor,
        title: 'Scanned QR Code',
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.only(left: Insets.dim_24),
          child: AppBoxedButton(
            onPressed: () => AppNavigator.of(context).pop(),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
            leading: HostedImage(args.qrValue.avatarUrl),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  args.qrValue.name,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textHeaderColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const YBox(Insets.dim_4),
                Text(
                  '**** **** **** 1121',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textHeaderColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                )
              ],
            ),
            trailing: InkWell(
              onTap: () {
                // use this to ask user to send to this address
              },
              child: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: AppColors.black.withOpacity(0.6),
                size: Insets.dim_24,
              ),
            ),
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
                  data: args.qrValue.accountNumber,
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
