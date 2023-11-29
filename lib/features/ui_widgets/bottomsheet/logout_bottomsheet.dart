import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class LogoutBottomSheet extends StatelessWidget
    with BaseBottomSheetMixin, LogoutMixin {
  LogoutBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.symmetric(horizontal: Insets.dim_6),
      shadowColor: AppColors.black,
      backgroundColor: AppColors.white,
      elevation: 5,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Insets.dim_16),
      ),
      icon: const Icon(
        Icons.logout,
        size: 40,
        color: AppColors.orangeColor,
      ),
      title: Text(
        'Session expired. Please login again',
        textAlign: TextAlign.center,
        style: context.textTheme.headlineLarge!.copyWith(
          color: AppColors.textHeaderColor,
          fontWeight: FontWeight.w500,
          fontSize: Insets.dim_24,
        ),
      ),
      actions: [
        AppButton(
          backgroundColor: AppColors.orangeColor,
          textTitle: 'Logout',
          action: () => sessionTimeout(context: context),
        ),
      ],
    );
  }
}

class DialogPage<T> extends Page<T> {
  const DialogPage({
    required this.builder,
    this.anchorPoint,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });
  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final WidgetBuilder builder;

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
        context: context,
        settings: this,
        builder: builder,
        anchorPoint: anchorPoint,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        useSafeArea: useSafeArea,
        themes: themes,
      );
}
