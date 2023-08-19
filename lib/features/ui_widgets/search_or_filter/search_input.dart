import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchTextInputField extends StatelessWidget {
  const SearchTextInputField({
    this.title = 'Search',
    this.showLeading = true,
    this.onChanged,
    this.onCancelPressed,
    this.showTrailing = true,
    Key? key,
  }) : super(key: key);
  final bool showLeading;
  final bool showTrailing;
  final String title;
  final ValueChanged<String>? onChanged;
  final void Function()? onCancelPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Insets.dim_8),
      decoration: BoxDecoration(
        color: AppColors.borderColor,
        borderRadius: Corners.smBorder,
      ),
      child: Row(
        children: [
          Expanded(
            child: AppTextFormField(
              onChanged: onChanged,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.borderColor,
                hintText: title,
                hintStyle: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                constraints: const BoxConstraints(maxHeight: 44),
                contentPadding: EdgeInsets.only(
                  bottom: Insets.dim_8,
                  right: Insets.dim_8,
                  left: showLeading ? 0.0 : Insets.dim_8,
                ),
                prefixIcon: showLeading
                    ? const Icon(
                        PhosphorIcons.magnifyingGlass,
                        color: Colors.black,
                        size: 20,
                      )
                    : null,
              ),
            ),
          ),
          Visibility(
            visible: showTrailing,
            child: TextButton(
              onPressed: onCancelPressed,
              child: Text(
                'Cancel',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.textHeaderColor,
                  fontWeight: FontWeight.w700,
                  fontSize: Insets.dim_16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
