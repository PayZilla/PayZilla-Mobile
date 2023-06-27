import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchTextInputField extends StatelessWidget {
  const SearchTextInputField({
    this.title = 'Search merchant tag or business',
    this.showLeading = true,
    this.onChanged,
    Key? key,
  }) : super(key: key);
  final bool showLeading;
  final String title;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return AfrichangeTextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
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
    );
  }
}
