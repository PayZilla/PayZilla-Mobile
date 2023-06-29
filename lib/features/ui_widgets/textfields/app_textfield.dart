import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/data/core_data.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    Key? key,
    this.labelText,
    this.prefixText,
    this.initialValue,
    this.style,
    this.suffixIcon,
    this.inputType,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.maxLines = 1,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.enableInteractiveSelection = true,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.enabled = true,
    this.showAsterisk = false,
    this.labelStyle,
    this.hintStyle,
    this.isLoading = false,
    this.suffixText,
    this.decoration,
    this.autoValidateMode,
  }) : super(key: key);
  final String? labelText, prefixText;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final String? Function(String? input)? validator;
  final Function(String input)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final String? hintText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final bool enableInteractiveSelection;
  final bool? obscureText;
  final bool enabled;
  final bool isLoading;
  final bool showAsterisk;
  final String? suffixText;
  final InputDecoration? decoration;
  final AutovalidateMode? autoValidateMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Row(
            children: [
              Text(
                labelText!,
                style: labelStyle ??
                    context.textTheme.bodyMedium
                        ?.apply(color: AppColors.textHeaderColor),
              ),
              Visibility(
                visible: showAsterisk,
                child: Text(
                  '*',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.borderErrorColor,
                  ),
                ),
              ),
            ],
          ),
          const YBox(Insets.dim_4),
        ],
        IgnorePointer(
          ignoring: isLoading,
          child: TextFormField(
            controller: controller,
            onSaved: (input) => onSaved?.call((input ?? '').trim()),
            autovalidateMode: autoValidateMode,
            onEditingComplete: onEditingComplete,
            obscureText: obscureText!,
            enableInteractiveSelection: enableInteractiveSelection,
            maxLines: maxLines,
            focusNode: focusNode,
            inputFormatters: inputFormatters,
            initialValue: initialValue,
            keyboardType: inputType,
            textAlign: textAlign,
            enabled: enabled,
            style: style,
            decoration: decoration ??
                InputDecoration(
                  suffixStyle: TextStyle(
                    color: AppColors.borderColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  suffixText: suffixText,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  hintText: hintText,
                  prefixText: prefixText,
                  labelStyle: labelStyle,
                  hintStyle:
                      hintStyle ?? const TextStyle(color: Colors.black26),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Insets.dim_16,
                    vertical: maxLines == 1 ? 4.0 : 16.0,
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.4,
                      color: Colors.red,
                    ),
                  ),
                ),
            onChanged: onChanged,
            validator: validator,
          ),
        ),
      ],
    );
  }
}

class ClickableFormField extends StatelessWidget {
  const ClickableFormField({
    Key? key,
    this.labelText,
    this.initialValue,
    this.suffixIcon,
    this.inputType,
    this.onChanged,
    this.onEditingComplete,
    this.onPressed,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.maxLines = 1,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.enableInteractiveSelection = true,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.enabled = true,
    this.labelStyle,
  }) : super(key: key);
  final String? labelText;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final String? Function(String? input)? validator;
  final Function(String input)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final Function()? onPressed;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final FocusNode? focusNode;
  final bool enableInteractiveSelection;
  final TextAlign textAlign;
  final String? hintText;
  final bool? obscureText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool enabled;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(labelText!, style: const TextStyle(fontSize: 13)),
          const YBox(Insets.dim_4),
        ],
        InkWell(
          onTap: onPressed,
          child: IgnorePointer(
            child: AppTextFormField(
              hintText: hintText,
              initialValue: initialValue,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon ??
                  const Icon(
                    PhosphorIcons.caretDown,
                    size: 18,
                  ),
              inputType: inputType,
              onChanged: onChanged,
              onEditingComplete: onEditingComplete,
              onSaved: onSaved,
              validator: validator,
              inputFormatters: inputFormatters,
              maxLines: maxLines,
              focusNode: focusNode,
              textAlign: textAlign,
              obscureText: obscureText,
              enableInteractiveSelection: enableInteractiveSelection,
              controller: controller,
              enabled: enabled,
              labelStyle: labelStyle,
            ),
          ),
        ),
      ],
    );
  }
}

class PhoneNumberTextFormField extends StatefulWidget {
  const PhoneNumberTextFormField({
    Key? key,
    this.labelText,
    this.initialValue,
    this.textFieldIcon,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.enableInteractiveSelection = true,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.enabled = true,
    this.labelStyle,
    this.style,
    this.showCountryList = true,
    this.phoneNumberCountry,
  }) : super(key: key);
  final String? labelText;
  final PhoneNumber? initialValue;
  final Widget? textFieldIcon;
  final Function(String input)? onChanged;
  final Function(PhoneNumber?)? onSaved;
  final Function()? onEditingComplete;
  final FocusNode? focusNode;
  final bool enableInteractiveSelection;
  final TextAlign textAlign;
  final String? hintText;
  final bool? obscureText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool enabled;
  final bool showCountryList;
  final TextStyle? labelStyle, style;
  final CountryData? phoneNumberCountry;

  @override
  State<PhoneNumberTextFormField> createState() =>
      _PhoneNumberTextFormFieldState();
}

class _PhoneNumberTextFormFieldState extends State<PhoneNumberTextFormField> {
  late CountryData phoneNumberCountry;
  @override
  void initState() {
    super.initState();
    phoneNumberCountry =
        widget.phoneNumberCountry ?? phoneNumberCountryList()[0];
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      style: widget.style,
      prefixIcon: SizedBox(
        height: 40,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const XBox(Insets.dim_8),
            LocalSvgImage(phoneNumberCountry.flag),
            const XBox(Insets.dim_4),
            Text(phoneNumberCountry.countryPhoneCode),
            const XBox(Insets.dim_4),
            const Icon(
              PhosphorIcons.caretDown,
              size: 18,
              color: AppColors.deeperDark,
            ),
            const XBox(Insets.dim_4),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: Insets.dim_14),
              child: VerticalDivider(width: 0, thickness: 1.5),
            ),
            const XBox(Insets.dim_10),
          ],
        ),
      ).onTap(() async {
        if (!widget.showCountryList) return;
        final country = await FutureBottomSheet<CountryData>(
          title: 'Select country',
          future: () => Future.value(phoneNumberCountryList()),
          itemBuilder: (context, item) {
            return ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(top: Insets.dim_4),
                child: LocalSvgImage(item.flag),
              ),
              title: Text('(${item.countryPhoneCode}) ${item.countryName}'),
            );
          },
        ).show(context);
        if (country != null) {
          setState(() {
            phoneNumberCountry = country;
          });
        }
      }),
      labelText: widget.labelText ?? 'Phone Number',
      hintText: widget.hintText ?? 'Enter phone number',
      initialValue: widget.initialValue?.number,
      suffixIcon: widget.textFieldIcon,
      inputType: TextInputType.number,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onSaved: (input) => widget.onSaved?.call(
        PhoneNumber(
          number: '$input',
          dialCode: phoneNumberCountry.countryPhoneCode,
        ),
      ),
      validator: (input) => Validators.validatePhoneNumber(
        maxLength: phoneNumberCountry.maxLength,
      )(input),
      inputFormatters: [
        LengthLimitingTextInputFormatter(phoneNumberCountry.maxLength),
        FilteringTextInputFormatter.digitsOnly,
      ],
      focusNode: widget.focusNode,
      textAlign: widget.textAlign,
      obscureText: widget.obscureText,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      controller: widget.controller,
      enabled: widget.enabled,
      labelStyle: widget.labelStyle,
    );
  }
}

class AppDropDownField extends StatelessWidget {
  const AppDropDownField({
    Key? key,
    this.labelText,
    this.initialValue,
    this.textFieldIcon,
    this.inputType,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.maxLines = 1,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.enableInteractiveSelection = true,
    this.hintText,
    this.prefixIcon,
    this.controller,
    required this.items,
    required this.value,
    this.enabled = true,
  }) : super(key: key);
  final String? labelText;
  final String? initialValue;
  final Widget? textFieldIcon;
  final TextInputType? inputType;
  final String? Function(String? input)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final FocusNode? focusNode;
  final bool enableInteractiveSelection;
  final TextAlign textAlign;
  final String? hintText;
  final bool? obscureText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool enabled;

  final List<String> items;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(labelText!, style: const TextStyle(fontSize: 13)),
          const YBox(Insets.dim_4),
        ],
        DropdownButtonFormField<String>(
          isExpanded: true,
          validator: validator,
          onSaved: onSaved,
          decoration: getDropDownButtonDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            textFieldIcon: textFieldIcon,
          ),
          items: items
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
          value: value,
        ),
      ],
    );
  }
}

InputDecoration getDropDownButtonDecoration({
  String? labelText,
  String? hintText,
  Widget? prefixIcon,
  Widget? textFieldIcon,
  double radius = 4.0,
}) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    suffixIcon: textFieldIcon,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey[400]!,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.scaffold,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey[400]!,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
    ),
    hintText: hintText,
    labelText: labelText,
  );
}
