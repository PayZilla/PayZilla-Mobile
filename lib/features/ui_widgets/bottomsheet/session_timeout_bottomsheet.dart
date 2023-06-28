import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';

class SessionTimeoutBottomSheet extends StatelessWidget
    with BaseBottomSheetMixin, LogoutMixin {
  SessionTimeoutBottomSheet(this.reason, {Key? key}) : super(key: key);
  final String reason;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.dim_32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const YBox(Insets.dim_16),
          const Text(
            'Session Timeout',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
          ),
          const YBox(Insets.dim_8),
          Text(
            reason,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const YBox(Insets.dim_32),
          AppButton(
            textTitle: 'Log In',
            action: sessionLogout,
          ),
          const YBox(Insets.dim_16),
        ],
      ),
    );
  }
}
