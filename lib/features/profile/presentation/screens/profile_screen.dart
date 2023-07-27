import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.read<ProfileProvider>();
    return AppScaffold(
      useBodyPadding: false,
      appBar: CustomAppBar(
        centerTitle: true,
        leading: const SizedBox.shrink(),
        titleWidget: Text(
          'Profile',
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: 0.30,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(Insets.dim_12),
            height: context.getHeight(0.18),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.textBodyColor.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 10,
                )
              ],
            ),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const LocalImage(
                selfie,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const YBox(Insets.dim_12),
          Text(
            'John O. Williams',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textHeaderColor,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              letterSpacing: 0.30,
            ),
          ),
          const YBox(Insets.dim_6),
          Text(
            'tommyjason@gmail.com',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textBodyColor,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              letterSpacing: 0.30,
            ),
          ),
          const YBox(Insets.dim_12),
          Expanded(
            child: ListView.builder(
              itemCount: profile.profileWidget.take(4).length,
              itemBuilder: (context, index) {
                final data = profile.profileWidget[index];
                return ProfileListTileWidget(
                  args: ProfileListTileWidgetArgs(
                    asset: data.asset,
                    title: data.title,
                    onTap: () => data.todo!(context),
                  ),
                );
              },
            ),
          ),
          const YBox(Insets.dim_12),
          Divider(
            color: AppColors.black.withOpacity(0.5),
            indent: Insets.dim_24,
            endIndent: Insets.dim_24,
          ),
          const YBox(Insets.dim_12),
          ProfileListTileWidget(
            args: ProfileListTileWidgetArgs(
              asset: profile.profileWidget[4].asset,
              title: profile.profileWidget[4].title,
              onTap: () => profile.profileWidget[4].todo!(context),
            ),
          ),
          ProfileListTileWidget(
            args: ProfileListTileWidgetArgs(
              asset: profile.profileWidget[5].asset,
              title: profile.profileWidget[5].title,
              onTap: () => profile.profileWidget[5].todo!(context),
            ),
          ),
          const YBox(Insets.dim_18),
        ],
      ),
    );
  }
}
