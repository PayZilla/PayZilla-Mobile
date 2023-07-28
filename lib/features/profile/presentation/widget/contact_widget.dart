import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

Widget contactWidget(BuildContext context) {
  return Row(
    children: [
      const HostedImage(
        'https://picsum.photos/200/300',
        height: Insets.dim_100,
      ),
      const XBox(Insets.dim_14),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'John Doe',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textHeaderColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 0.30,
            ),
          ),
          const YBox(Insets.dim_16),
          Text(
            '**** **** **** 2564',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textBodyColor,
              fontWeight: FontWeight.w400,
              fontSize: 11,
              letterSpacing: 0.30,
            ),
          ),
        ],
      )
    ],
  );
}
