import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';

mixin BaseBottomSheetMixin {
  Widget build(BuildContext context);

  Future<R?> show<R>(
    BuildContext context, {
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<R>(
      isScrollControlled: true,
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: build,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Insets.dim_16),
        ),
      ),
    );
  }
}
