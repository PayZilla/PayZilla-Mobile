import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/card/card.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class MyCardScreen extends StatelessWidget {
  const MyCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      useBodyPadding: false,
      appBar: CustomAppBar(
        centerTitle: true,
        leading: const SizedBox.shrink(),
        titleWidget: Text(
          'My Card',
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 0.30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.dim_22),
        child: Column(
          children: [
            const AtmCardWidget(
              color: AppColors.textHeaderColor,
            ),
            const YBox(Insets.dim_22),
            const AtmCardWidget2(
              color: AppColors.textHeaderColor,
            ),
            const YBox(Insets.dim_22),
            InkWell(
              onTap: () =>
                  AppNavigator.of(context).push(AppRoutes.startCreateCard),
              child: Container(
                height: context.getHeight(0.07),
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: Corners.mdBorder,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      color: AppColors.textHeaderColor,
                    ),
                    const XBox(Insets.dim_12),
                    Text(
                      'Add new card',
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textHeaderColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: 0.30,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
