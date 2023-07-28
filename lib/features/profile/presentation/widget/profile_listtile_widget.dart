import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class ProfileListTileWidgetArgs {
  ProfileListTileWidgetArgs({
    this.onTap,
    this.asset,
    required this.title,
    this.assetColor,
    this.subtitle,
    this.trailing,
    this.leading,
  });

  final Function()? onTap;
  final Color? assetColor;
  final String? asset;
  final String title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? leading;
}

class ProfileListTileWidget extends StatelessWidget {
  const ProfileListTileWidget({
    super.key,
    required this.args,
  });

  final ProfileListTileWidgetArgs args;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Insets.dim_24,
        vertical: Insets.dim_8,
      ),
      onTap: () => args.onTap!(),
      leading: args.leading == null && args.asset == null
          ? null
          : Container(
              decoration: BoxDecoration(
                color: AppColors.black.withOpacity(0.05),
                borderRadius: Corners.xsBorder,
              ),
              padding: const EdgeInsets.all(Insets.dim_12),
              child: LocalSvgImage(
                args.asset ?? logoSvg,
                color: args.assetColor,
              ),
            ),
      title: Text(
        args.title,
        style: context.textTheme.bodyMedium!.copyWith(
          color: AppColors.textHeaderColor,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: 0.30,
        ),
      ),
      subtitle: args.subtitle,
      trailing: args.trailing ??
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: Insets.dim_12,
            color: AppColors.black.withOpacity(0.5),
          ),
    );
  }
}
