import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: 'Frequently Asked',
        leading: Padding(
          padding: const EdgeInsets.only(left: Insets.dim_24),
          child: AppBoxedButton(
            onPressed: () {
              AppNavigator.of(context).push(AppRoutes.profile);
            },
          ),
        ),
        leadingWidth: 80,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You have any question ?',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textHeaderColor,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              letterSpacing: 0.30,
            ),
          ),
          const YBox(Insets.dim_40),
          const SearchTextInputField(
            showTrailing: false,
          ),
          const YBox(Insets.dim_24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Frequently Asked',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  letterSpacing: 0.30,
                ),
              ),
              Text(
                'View All',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  letterSpacing: 0.30,
                ),
              ).onTap(() {
                showInfoNotification('Coming soon1!!!');
              }),
            ],
          ),
          const YBox(Insets.dim_24),
          faqColumnWidget(context),
          faqColumnWidget(
            context,
            title: 'How to create a card for PayZilla?',
            subtitle:
                'You can select the create card menu then select "Add New Card" select the continue button then you ...',
          ),
          faqColumnWidget(
            context,
            title: 'How to Top Up on PayZilla?',
            subtitle:
                'Click the Top Up menu then select the amount of money and the method then click the "top up now" button...',
          ),
          const Spacer(),
          AppButton(
            textTitle: 'Load more',
            action: () {},
            backgroundColor: AppColors.grey,
            color: AppColors.textHeaderColor,
          ),
        ],
      ),
    );
  }

  Container faqColumnWidget(
    BuildContext context, {
    String? title,
    String? subtitle,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: Corners.mdBorder,
        border: Border.all(color: AppColors.grey),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Insets.dim_24,
        horizontal: Insets.dim_16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? 'How do I create a PayZilla account?',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textHeaderColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              letterSpacing: 0.30,
            ),
          ),
          const YBox(Insets.dim_12),
          Text(
            subtitle ??
                'You can create a Smartpay account by: download and  open the smartpay application first then select ...',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textBodyColor,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              letterSpacing: 0.30,
            ),
          ),
        ],
      ),
    );
  }
}
