import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/qr/qr.dart';
import 'package:pay_zilla/features/transaction/transaction.dart';
import 'package:pay_zilla/features/ui_widgets/state/loading.dart';
import 'package:provider/provider.dart';

class ScanQrScreenArgs {
  ScanQrScreenArgs({
    this.isSendMoney = false,
  });
  final bool isSendMoney;
}

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({super.key, required this.args});
  final ScanQrScreenArgs? args;

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  MobileScannerController cameraController = MobileScannerController();
  ValidateBankOrWalletDto requestDto = ValidateBankOrWalletDto.empty();
  WalletChannel walletChannel = WalletChannel.empty();
  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qrProvider = context.watch<TransactionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: Insets.dim_32,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: Insets.dim_32,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        placeholderBuilder: (p0, p1) {
          if (qrProvider.valBanksOrWalletResponse.isLoading) {
            return const Center(
              child: AppCircularLoadingWidget(
                size: Insets.dim_32,
                color: AppColors.white,
              ),
            );
          }
          return Container();
        },
        onDetect: (capture) {
          final barcode = capture.barcodes;
          if (barcode.isNotEmpty) {
            walletChannel = walletChannel.copyWith(
              paymentId: barcode.first.rawValue,
            );
            requestDto = requestDto.copyWith(
              walletChannel: walletChannel,
              channel: Channel.wallet,
            );
            qrProvider.validateBanksOrWallet(requestDto, context).then((value) {
              if (qrProvider.valBanksOrWalletResponse.isSuccess) {
                if (widget.args!.isSendMoney) {
                  AppNavigator.of(context).push(
                    AppRoutes.sendMoney,
                    args: SendMoneyScreenArgs(
                      contact: qrProvider.valBanksOrWalletResponse.data,
                      paymentId: requestDto.walletChannel.paymentId,
                    ),
                  );
                } else {
                  AppNavigator.of(context).push(
                    AppRoutes.qrShowScan,
                    args: OtherUserQrScreenArgs(
                      qrProvider.valBanksOrWalletResponse.data!,
                      walletChannel.paymentId,
                    ),
                  );
                }
              }
            });
          }
        },
      ),
    );
  }
}
