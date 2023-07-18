import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class StartCreateCardScreen extends StatelessWidget {
  const StartCreateCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          LocalImage(
            atmMultiCardPng,
            height: context.getHeight(0.45),
          ),
          const Spacer(),
          Text(
            'Create your PayZilla Card',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textHeaderColor,
              fontWeight: FontWeight.w700,
              fontSize: 32,
            ),
          ),
          const YBox(Insets.dim_12),
          Text(
            'The customizable, no hidden fee, instant discount debit or credit card',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textBodyColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const YBox(Insets.dim_44),
          AppSolidButton(
            textTitle: 'Get Free Card',
            action: () =>
                AppNavigator.of(context).push(AppRoutes.chooseCardStyle),
          ),
        ],
      ),
    );
  }
}
