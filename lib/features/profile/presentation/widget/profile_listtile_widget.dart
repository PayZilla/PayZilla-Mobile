import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class ListTileWidgetArgs {
  ListTileWidgetArgs({
    this.onTap,
    this.asset,
    required this.title,
    this.assetColor,
    this.subtitle,
    this.trailing,
    this.leading,
    this.isRead = false,
  });

  final Function()? onTap;
  final Color? assetColor;
  final String? asset;
  final String title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final bool isRead;
}

class AppListTileWidget extends StatelessWidget {
  const AppListTileWidget({
    super.key,
    required this.args,
  });

  final ListTileWidgetArgs args;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Insets.dim_24,
        vertical: Insets.dim_8,
      ),
      tileColor:
          args.isRead ? AppColors.white : AppColors.appGreen.withOpacity(0.1),
      shape: const RoundedRectangleBorder(
        borderRadius: Corners.xsBorder,
        side: BorderSide(
          color: AppColors.grey,
          width: 1.5,
        ),
      ),
      onTap: args.onTap == null ? null : () => args.onTap!(),
      title: Text(
        args.title,
        style: context.textTheme.bodyMedium!.copyWith(
          color: AppColors.textHeaderColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
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
