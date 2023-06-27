import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class AfrichangeGreyButton extends AfrichangeButton {
  const AfrichangeGreyButton({
    required String textTitle,
    required VoidCallback action,
    bool fullWidth = true,
    bool? deActivate,
    bool showLoading = false,
    Key? key,
  }) : super(
          textTitle: textTitle,
          deActivate: deActivate,
          action: action,
          showLoading: showLoading,
          fullWidth: fullWidth,
          color: AppColors.white,
          backgroundColor: AppColors.btnSecondaryColor,
          key: key,
        );
}

class AfrichangePurpleButton extends AfrichangeButton {
  AfrichangePurpleButton({
    required String textTitle,
    required VoidCallback action,
    bool? deActivate,
    Key? key,
    bool fullWidth = true,
    bool showLoading = false,
  }) : super(
          textTitle: textTitle,
          action: action,
          deActivate: deActivate,
          showLoading: showLoading,
          fullWidth: fullWidth,
          color: AppColors.white,
          backgroundColor: AppColors.borderColor,
          key: key,
        );
}

class AfrichangeButton extends StatelessWidget {
  const AfrichangeButton({
    required this.textTitle,
    required this.action,
    this.deActivate,
    Key? key,
    this.fullWidth = true,
    this.showLoading,
    this.color,
    this.backgroundColor,
    this.loadingColor,
    this.child,
  }) : super(key: key);
  final String textTitle;
  final bool fullWidth;
  final bool? showLoading;
  final bool? deActivate;
  final Color? color, backgroundColor, loadingColor;
  final VoidCallback action;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            ? AfrichangeLoadingWidget(
                color: backgroundColor != null ? Colors.white : loadingColor,
              )
            : child ??
                Text(
                  textTitle,
                  style: context.textTheme.bodyMedium.size(16).copyWith(
                        color: deActivate == true
                            ? Colors.grey.shade400
                            : color ?? Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                ),
      ),
    );
  }
}
