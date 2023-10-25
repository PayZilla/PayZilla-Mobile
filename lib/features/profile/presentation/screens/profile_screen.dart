import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/profile/profile.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.read<ProfileProvider>();
    final authUser = context.watch<AuthProvider>();

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
      body: Stack(
        children: [
          ListView(
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
                  child: HostedImage(
                    authUser.user.profileImage,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const YBox(Insets.dim_12),
              Center(
                child: Text(
                  authUser.user.fullName,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textHeaderColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    letterSpacing: 0.30,
                  ),
                ),
              ),
              const YBox(Insets.dim_6),
              Center(
                child: Text(
                  authUser.user.email,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textBodyColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    letterSpacing: 0.30,
                  ),
                ),
              ),
              const YBox(Insets.dim_12),
              SizedBox(
                height: context.getHeight(0.3),
                child: ListView.builder(
                  itemCount: profile.profileWidget.take(4).length,
                  itemBuilder: (context, index) {
                    final data = profile.profileWidget[index];
                    return AppListTileWidget(
                      args: ListTileWidgetArgs(
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
              AppListTileWidget(
                args: ListTileWidgetArgs(
                  asset: profile.profileWidget[4].asset,
                  title: profile.profileWidget[4].title,
                  onTap: () => profile.profileWidget[4].todo!(context),
                ),
              ),
              AppListTileWidget(
                args: ListTileWidgetArgs(
                  asset: profile.profileWidget[5].asset,
                  title: profile.profileWidget[5].title,
                  onTap: () => profile.profileWidget[5].todo!(context),
                ),
              ),
              AppListTileWidget(
                args: ListTileWidgetArgs(
                  leading: const Icon(
                    PhosphorIcons.trashBold,
                    size: 30,
                    color: AppColors.borderErrorColor,
                  ),
                  title: 'Log out',
                  onTap: () => profile.logOut(context),
                  trailing: profile.loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: AppCircularLoadingWidget(),
                        )
                      : null,
                ),
              ),
              const YBox(Insets.dim_18),
            ],
          ),
          if (profile.loading) Container(color: Colors.transparent)
        ],
      ),
    );
  }
}
