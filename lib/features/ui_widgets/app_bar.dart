import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/navigation/navigation.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
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
    this.elevation = 0,
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
  final double? elevation;
  final bool useSmallFont;
  final Widget? titleWidget;
  final Color? leadingColor;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
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
      leading: leading ?? const AppBoxedButton(),
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

class AppBoxedButton extends StatelessWidget {
  const AppBoxedButton({
    super.key,
    this.onPressed,
    this.icon,
    this.width = 40,
    this.color,
  });
  final Function()? onPressed;
  final Widget? icon;
  final double width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: color ?? const Color(0xFFE5E7EB),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: FittedBox(
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed ?? AppNavigator.of(context).pop,
          icon: icon ??
              Icon(
                Icons.chevron_left_rounded,
                size: 35,
                color: color ?? AppColors.black,
              ),
          color: color ?? AppColors.black,
          splashRadius: 30,
        ),
      ),
    );
  }
}
