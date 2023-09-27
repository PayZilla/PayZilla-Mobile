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
    this.labelDistance = Insets.dim_4,
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
  final double labelDistance;
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
                    context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textBodyColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
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
          YBox(labelDistance),
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
              hintStyle: labelStyle,
              initialValue: initialValue,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon ??
                  const Icon(
                    PhosphorIcons.caretDown,
                    size: 18,
                    color: AppColors.black,
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
    this.labelDistance = Insets.dim_4,
    this.showCountryList = true,
    this.phoneNumberCountry,
  }) : super(key: key);
  final String? labelText;
  final String? initialValue;
  final Widget? textFieldIcon;
  final Function(String input)? onChanged;
  final Function(String?)? onSaved;
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
  final double labelDistance;
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
        widget.phoneNumberCountry ?? phoneNumberCountryList().first;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      prefixIcon: widget.prefixIcon,
      style: widget.style,
      hintText: widget.hintText ?? 'Enter phone number',
      initialValue: widget.initialValue,
      suffixIcon: widget.textFieldIcon,
      labelDistance: widget.labelDistance,
      labelText: widget.labelText,
      inputType: TextInputType.number,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onSaved: (input) => widget.onSaved?.call(input),
      validator: (input) => Validators.validatePhoneNumber(
        maxLength: phoneNumberCountry.maxLength,
        title: widget.labelText ?? 'Phone',
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

class SpecialAmountTextField extends StatefulWidget {
  const SpecialAmountTextField({
    super.key,
    this.onSaved,
    required this.controller,
    required this.validator,
  });
  final dynamic Function(String?)? onSaved;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<SpecialAmountTextField> createState() => _SpecialAmountTextFieldState();
}

class _SpecialAmountTextFieldState extends State<SpecialAmountTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Corners.mdBorder,
        border: Border.all(
          color: const Color(0xffE5E7EB),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.dim_16,
        vertical: Insets.dim_16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter amount:',
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.textBodyColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              letterSpacing: 0.30,
            ),
          ),
          const YBox(Insets.dim_16),
          IgnorePointer(
            ignoring: false,
            child: AppTextFormField(
              hintText: '00.00',
              prefixIcon: SizedBox(
                height: 40,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: Insets.dim_16,
                        right: Insets.dim_6,
                      ),
                      child: Text(
                        'NG',
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: AppColors.textHeaderColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                    const Icon(
                      PhosphorIcons.caretDown,
                      size: 18,
                      color: AppColors.btnPrimaryColor,
                    ),
                    const XBox(Insets.dim_26),
                  ],
                ),
              ).onTap(() async {
                final country = await FutureBottomSheet<CountryData>(
                  title: 'Select country',
                  future: () async => [phoneNumberCountryList().first],
                  itemBuilder: (context, item) {
                    return ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: LocalSvgImage(item.flag),
                      ),
                      title: Text(
                        '(${item.currencyCode}) ${item.countryName}',
                      ),
                    );
                  },
                ).show(context);
                if (country != null) {
                  setState(() {});
                }
              }),
              validator: widget.validator,
              onSaved: widget.onSaved,
              controller: widget.controller,
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.textHeaderColor,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ],
      ),
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
