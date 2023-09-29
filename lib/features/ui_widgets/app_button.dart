import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class AppSolidButton extends AppButton {
  const AppSolidButton({
    required String textTitle,
    required VoidCallback action,
    bool fullWidth = true,
    bool? deActivate,
    bool showLoading = false,
    Key? key,
    Color? backgroundColor,
  }) : super(
          textTitle: textTitle,
          deActivate: deActivate,
          action: action,
          showLoading: showLoading,
          fullWidth: fullWidth,
          color: AppColors.white,
          backgroundColor: backgroundColor ?? AppColors.btnPrimaryColor,
          key: key,
        );
}

class AppGradientButton extends AppButton {
  AppGradientButton({
    required String textTitle,
    required VoidCallback action,
    bool? deActivate,
    Key? key,
    bool fullWidth = true,
    bool showLoading = false,
  }) : super(
          textTitle: textTitle,
          action: action,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(-1, 0.01),
              end: Alignment(1, -0.01),
              colors: [
                Color(0xFF0A4D6A),
                AppColors.appSecondaryColor,
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
              )
            ],
          ),
          deActivate: deActivate,
          showLoading: showLoading,
          fullWidth: fullWidth,
          color: AppColors.white,
          backgroundColor: AppColors.borderColor.withOpacity(0.5),
          key: key,
        );
}

class AppButton extends StatelessWidget {
  const AppButton({
    required this.textTitle,
    required this.action,
    this.deActivate,
    Key? key,
    this.fullWidth = true,
    this.showLoading,
    this.color,
    this.backgroundColor,
    this.loadingColor,
    this.decoration,
    this.child,
  }) : super(key: key);
  final String textTitle;
  final bool fullWidth;
  final bool? showLoading;
  final bool? deActivate;
  final Decoration? decoration;
  final Color? color, backgroundColor, loadingColor;
  final VoidCallback action;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      height: Insets.dim_54.dx,
      width: fullWidth ? double.maxFinite : null,
      child: ElevatedButton(
        key: key,
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              backgroundColor: deActivate == true
                  ? MaterialStateProperty.all<Color>(Colors.grey.shade300)
                  : backgroundColor != null
                      ? MaterialStateProperty.all<Color>(backgroundColor!)
                      : null,
            ),
        onPressed: showLoading == true || deActivate == true ? null : action,
        child: showLoading == true
            ? AppCircularLoadingWidget(
                color: backgroundColor != null ? Colors.white : loadingColor,
              )
            : child ??
                Text(
                  textTitle,
                  style: context.textTheme.bodyMedium.size(16).copyWith(
                        color: deActivate == true
                            ? Colors.grey.shade400
                            : color ?? Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                ),
      ),
    );
  }
}
