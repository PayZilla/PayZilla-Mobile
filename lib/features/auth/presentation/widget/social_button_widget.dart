import 'package:flutter/widgets.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

Expanded socialAuthWidget(String asset, BuildContext context) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        showInfoNotification(context, 'COMING SOON', durationInMills: 3500);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: Corners.smBorder,
          border: Border.all(
            color: const Color(0xffE5E7EB),
          ),
        ),
        child: Center(child: LocalSvgImage(asset)),
      ),
    ),
  );
}
