import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    this.error,
    this.onRetry,
    this.buttonText,
    this.svg,
    this.img,
    Key? key,
  }) : super(key: key);

  final Function()? onRetry;
  final String? error;
  final String? buttonText;

  final String? svg;
  final String? img;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const YBox(Insets.dim_8),
          if (svg != null) LocalSvgImage(svg!),
          if (img != null) LocalImage(img!),
          const YBox(Insets.dim_8),
          Text(
            error ?? 'An unexpected error occurred',
            textAlign: TextAlign.center,
          ),
          const YBox(Insets.dim_10),
          OutlinedButton.icon(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(Insets.dim_0),
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.borderColor),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(
                  vertical: Insets.dim_6,
                  horizontal: Insets.dim_12,
                ),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: Corners.xsBorder,
                ),
              ),
            ),
            onPressed: onRetry,
            icon: const Icon(
              Icons.close,
              size: 20,
              color: Colors.white,
            ),
            label: Text(
              buttonText ?? 'Retry',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
