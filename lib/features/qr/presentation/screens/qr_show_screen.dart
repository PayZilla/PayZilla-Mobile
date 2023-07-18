import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrShowScreenArgs {
  QrShowScreenArgs(this.qrValue);

  final String qrValue;
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
        title: 'Scan QR Code',
        actions: [
          AppBoxedButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz_rounded,
              size: 35,
              color: AppColors.black,
            ),
          ),
          const XBox(Insets.dim_12),
        ],
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
            leading: LocalImage(logoPng),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John O.Willams',
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
            trailing: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: AppColors.black.withOpacity(0.3),
              size: Insets.dim_44,
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
                  data: args.qrValue,
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
