import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/qr/qr.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreenArgs {
  QRScreenArgs(this.qrValue);

  final String qrValue;
}

class QRScanScreen extends StatelessWidget {
  const QRScanScreen({super.key, required this.args});
  final QRScreenArgs args;

  @override
  Widget build(BuildContext context) {
    final transactionP = context.watch<TransactionProvider>();

    return AppScaffold(
      extendedBody: true,
      useBodyPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(qrBgPng),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.dim_22,
            vertical: Insets.dim_66,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppBoxedButton(
                    icon: Icon(
                      Icons.chevron_left_rounded,
                      size: 35,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    'Scan QR Code',
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  AppBoxedButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz_rounded,
                      size: 35,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (transactionP.valBanksOrWalletResponse.isLoading)
                const AppCircularLoadingWidget(
                  color: AppColors.white,
                  size: Insets.dim_32,
                )
              else ...[
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      LocalSvgImage(
                        qrBorderSvg,
                      ),
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          borderRadius: Corners.mdBorder,
                        ),
                        child: QrImageView(
                          data: args.qrValue,
                          size: 200,
                          backgroundColor: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const YBox(Insets.dim_40),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Insets.dim_12),
                  height: Insets.dim_50,
                  margin:
                      EdgeInsets.symmetric(horizontal: context.getWidth(0.15)),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.4),
                    borderRadius: Corners.mdBorder,
                    border: Border.all(color: AppColors.white),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LocalSvgImage(scanSvg),
                      const XBox(Insets.dim_12),
                      Text(
                        'Scan QR code ready',
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const Spacer(),
              if (transactionP.valBanksOrWalletResponse.data != null)
                InkWell(
                  onTap: () => AppNavigator.of(context).push(
                    AppRoutes.scanQrScreen,
                    args: ScanQrScreenArgs(),
                  ),
                  child: Container(
                    height: Insets.dim_80,
                    padding: const EdgeInsets.all(Insets.dim_20),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.4),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white),
                    ),
                    child: LocalSvgImage(
                      qrBoltSvg,
                      fit: BoxFit.contain,
                      color: AppColors.white,
                    ),
                  ),
                ),
              const YBox(Insets.dim_28),
            ],
          ),
        ),
      ),
    );
  }
}
