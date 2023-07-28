import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      useBodyPadding: false,
      appBar: CustomAppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: Insets.dim_24),
          child: AppBoxedButton(
            onPressed: () {
              AppNavigator.of(context).push(AppRoutes.profile);
            },
          ),
        ),
        leadingWidth: 80,
        titleWidget: Text(
          'Contacts',
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 0.30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.dim_24),
        child: ListView(
          children: [
            const SearchTextInputField(
              showTrailing: false,
            ),
            const YBox(Insets.dim_24),
            Text(
              'Recent contacts',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.textBodyColor,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: 0.30,
              ),
            ),
            const YBox(Insets.dim_24),
            ...List.generate(
              3,
              (index) => contactWidget(context),
            ).toList(),
            const YBox(Insets.dim_24),
            Divider(
              color: AppColors.black.withOpacity(0.5),
              indent: Insets.dim_14,
              endIndent: Insets.dim_14,
            ),
            const YBox(Insets.dim_24),
            Text(
              'All contacts',
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.textBodyColor,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: 0.30,
              ),
            ),
            const YBox(Insets.dim_24),
            ...List.generate(
              18,
              (index) => contactWidget(context),
            ).toList(),
          ],
        ),
      ),
    );
  }
}
