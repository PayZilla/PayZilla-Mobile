import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({
    required this.child,
    this.onDismiss,
    this.height,
    this.desc,
    this.title,
    this.isDismissible = true,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final void Function()? onDismiss;
  final bool isDismissible;
  final double? height;
  final String? title;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: height ?? context.getHeight(0.3),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Insets.dim_40),
            topLeft: Radius.circular(Insets.dim_40),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.dim_16,
        ),
        child: ListView(
          children: [
            const YBox(Insets.dim_20),
            if (title != null) ...[
              Text(
                title ?? '',
                style: context.textTheme.headlineMedium!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ],
            if (desc != null) ...[
              Padding(
                padding: const EdgeInsets.only(top: Insets.dim_8),
                child: Text(
                  desc ?? '',
                  style: context.textTheme.bodySmall,
                ),
              ),
            ],
            const YBox(Insets.dim_16),
            child,
          ],
        ),
      ),
    );
  }
}
