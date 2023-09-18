import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';

class LogoutBottomSheet extends StatelessWidget
    with BaseBottomSheetMixin, LogoutMixin {
  LogoutBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = Column(
      children: [
        const YBox(Insets.dim_8),
        const Text(
          'Are you sure you want to log out of your account?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Color(0xff222222),
          ),
        ),
        const YBox(Insets.dim_32),
        Row(
          children: [
            Expanded(
              child: AppGradientButton(
                textTitle: 'Cancel',
                action: () => AppNavigator.of(context).pop(),
              ),
            ),
            const YBox(Insets.dim_10),
            Expanded(
              child: AppButton(
                backgroundColor: AppColors.orangeColor,
                textTitle: 'Logout',
                action: logout,
              ),
            ),
          ],
        )
      ],
    );

    return BaseBottomSheet(child: child);
  }
}
