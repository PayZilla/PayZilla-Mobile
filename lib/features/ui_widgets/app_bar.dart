import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';

class AfrAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AfrAppBar({
    Key? key,
    this.title,
    this.onLeadingPressed,
    this.leading,
    this.actions,
    this.centerTitle,
    this.backgroundColor,
    this.appBarTitleColor,
    this.leadingWidth = 56,
    this.useSmallFont = false,
    this.titleWidget,
    this.leadingColor,
    this.bottom,
  }) : super(key: key);

  final String? title;

  final VoidCallback? onLeadingPressed;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? appBarTitleColor;

  final bool? centerTitle;
  final double? leadingWidth;
  final bool useSmallFont;
  final Widget? titleWidget;
  final Color? leadingColor;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: centerTitle,
      title: title != null
          ? Text(
              title!,
              style: TextStyle(
                color: appBarTitleColor,
                fontSize: !useSmallFont ? 18 : 15,
              ),
            )
          : titleWidget ?? const SizedBox.shrink(),
      leading: leading ??
          IconButton(
            onPressed: onLeadingPressed ?? AppNavigator.of(context).pop,
            icon: Icon(
              Icons.chevron_left_rounded,
              size: 30,
              color: leadingColor ?? AppColors.borderColor,
            ),
            color: AppColors.borderColor,
            splashRadius: 30,
          ),
      leadingWidth: leadingWidth,
      actions: [
        ...?actions,
      ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
