import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/qr/qr.dart';
import 'package:pay_zilla/features/ui_widgets/state/loading.dart';
import 'package:provider/provider.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({super.key});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  MobileScannerController cameraController = MobileScannerController();
  ValidateQRDto requestDto = ValidateQRDto.empty();
  WalletChannel walletChannel = WalletChannel.empty();
  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qrProvider = context.watch<QrProvider>();

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
          if (qrProvider.qrResponse.isLoading) {
            return const Center(
              child: AppLoadingWidget(
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
              walletType: WalletType.wallet,
            );
            qrProvider.validateQR(requestDto).then((value) {
              if (qrProvider.qrResponse.isSuccess) {
                AppNavigator.of(context).push(
                  AppRoutes.qrShowScan,
                  args: QrShowScreenArgs(qrProvider.qrResponse.data!),
                );
              }
            });
          }
        },
      ),
    );
  }
}
