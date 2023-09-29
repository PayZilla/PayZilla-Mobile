import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pinput/pinput.dart';

class PinTextField extends StatefulWidget {
  const PinTextField({
    this.numOfDigits = 4,
    this.keyboardType = TextInputType.number,
    this.size = 60,
    this.obscureText = false,
    this.onSaved,
    this.inputDecoration,
    this.controller,
    this.validator,
    this.otpError,
    Key? key,
  }) : super(key: key);
  final int numOfDigits;
  final double size;
  final Function(String?)? onSaved;
  final TextEditingController? controller;
  final String? Function(String? input)? validator;
  final TextInputType keyboardType;
  final String? otpError;
  final bool? obscureText;
  final PinTheme? inputDecoration;

  @override
  State<PinTextField> createState() => _PinTextFieldState();
}

class _PinTextFieldState extends State<PinTextField> {
  bool isPinNotValid = false;

  @override
  Widget build(BuildContext context) {
    final decoration = PinTheme(
      height: widget.size,
      width: widget.size,
      textStyle: const TextStyle(
        fontSize: 20,
        color: AppColors.textHeaderColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black.withOpacity(0.5)),
        borderRadius: Corners.smBorder,
        color: AppColors.borderColor,
      ),
    );

    return Column(
      children: [
        Pinput(
          obscureText: widget.obscureText!,
          length: widget.numOfDigits,
          keyboardType: widget.keyboardType,
          onChanged: widget.onSaved,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.numOfDigits),
            FilteringTextInputFormatter.digitsOnly,
          ],
          defaultPinTheme: widget.inputDecoration ?? decoration,
          controller: widget.controller,
          submittedPinTheme: widget.inputDecoration ?? decoration,
          followingPinTheme: widget.inputDecoration ?? decoration,
          validator: (input) {
            final isNotValid = input == null ||
                input.isEmpty ||
                input.length < widget.numOfDigits;
            if (isNotValid && widget.validator?.call(input) == null) {
              isPinNotValid = true;
              return '';
            } else {
              isPinNotValid = false;
            }
            return null;
          },
        ),
        if (isPinNotValid)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              widget.otpError ?? 'Invalid OTP entered',
              style: const TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
