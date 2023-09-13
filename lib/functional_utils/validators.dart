import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class Validators {
  static String? Function(String?) validateAccountNumber({int maxLength = 10}) {
    return (String? value) {
      value = harmonize(value);
      const Pattern pattern = '^[0-9]';
      final regex = RegExp(pattern.toString());
      if (value.isEmpty || !regex.hasMatch(value)) {
        return 'please enter a valid account number';
      }
      if (value.length < maxLength) {
        return 'Account number must be an $maxLength characters digits';
      }
      return null;
    };
  }

  static String? Function(String?) validatePhoneNumber({
    int maxLength = 10,
    String title = 'phone',
  }) {
    return (String? value) {
      value = harmonize(value);
      const Pattern pattern = '^[0-9]';
      final regex = RegExp(pattern.toString());
      if (value.isEmpty || !regex.hasMatch(value)) {
        return 'please enter a valid $title number';
      }
      if (value.length < maxLength) {
        return '$title number must be an $maxLength characters digits';
      }
      return null;
    };
  }

  static String? validateEmail({required String? value}) {
    const Pattern emailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regex = RegExp(emailPattern.toString());
    if (harmonize(value).isEmpty || !regex.hasMatch(harmonize(value))) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }

  static String? Function(String?) validateString({
    int minLength = 1,
    int? maxLength,
    String? error,
  }) {
    return (String? value) {
      final res = harmonize(value);
      if (res.isEmpty && res.length < minLength) {
        return error ?? 'Field is required.';
      }

      if (maxLength != null) {
        if (minLength == maxLength && res.length != minLength) {
          return 'Field must be $minLength characters';
        }
        if (res.length < minLength || res.length > maxLength) {
          return 'Field must be $minLength-$maxLength characters';
        }
      }
      if (res.length < minLength) {
        return 'Field must have a minimum of $minLength characters';
      }
      if (maxLength != null && res.length < maxLength) {
        return 'Field must not have more than $maxLength characters';
      }
      return null;
    };
  }

  static String? Function(String?) validateFullName({
    int minLength = 1,
    int? maxLength,
    String? error,
  }) {
    const Pattern fullNameSplitPattern = r'\s+';
    final regex = RegExp(fullNameSplitPattern.toString());
    return (String? value) {
      final res = harmonize(value);
      if (res.isEmpty && res.length < minLength) {
        return error ?? 'Field is required.';
      }

      if (maxLength != null) {
        if (minLength == maxLength && res.length != minLength) {
          return 'Field must be $minLength characters';
        }
        if (res.length < minLength || res.length > maxLength) {
          return 'Field must be $minLength-$maxLength characters';
        }
      }

      if (maxLength != null && res.length < maxLength) {
        return 'Field must not have more than $maxLength characters';
      }

      if (!regex.hasMatch(res)) {
        return 'Enter first and last name';
      }
      return null;
    };
  }

  static String? validateDate(String? value) {
    const error = 'Field must be a valid date';
    final res = harmonize(value);

    if (res.isNotEmpty) {
      return 'Field is required.';
    }
    if (res.length != 10) {
      return error;
    }
    final day = res.substring(0, 2).toInt();
    final month = res.substring(3, 5).toInt();
    final year = res.substring(6, 10).toInt();
    if (day == -1 ||
        month == -1 ||
        year == -1 ||
        day > 31 ||
        month > 12 ||
        year < 1900) {
      return error;
    }
    return null;
  }

  static String? Function(String?) validatePassword({
    int minLength = 8,
    int maxLength = 255,
  }) {
    return (String? value) {
      final res = harmonize(value);

      if (res.isEmpty) {
        return 'Password is required';
      } else if (res.length < minLength || res.length > maxLength) {
        return 'Password must be at least $minLength characters';
      } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%\^&\*])')
          .hasMatch(res)) {
        return 'Password should contain at least one special character,a number and a capital letter';
      }
      return null;
    };
  }

  static String? Function(File) validateFile([String? error]) {
    return (File file) {
      if (file.path.isEmpty) {
        return error ?? 'Invalid File.';
      }
      return null;
    };
  }

  static String? Function(String?) validateAmount([
    double? minAmount,
    double? maxAmount,
    String? error,
  ]) {
    return (String? value) {
      value = harmonize(value);

      if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)) {
        return error ?? 'Not a valid amount.';
      }

      if (value.isEmpty) {
        return error ?? 'Amount is required.';
      }

      final amount = double.tryParse(value);

      if (amount == null) {
        return error ?? 'Invalid Amount.';
      }

      if (minAmount != null && amount < minAmount) {
        return error ??
            "Amount can't be less than ${minAmount.toInt().inNaira}";
      }
      if (maxAmount != null && amount > maxAmount) {
        return error ??
            "Amount can't be greater than ${maxAmount.toInt().inNaira}";
      }
      return null;
    };
  }

  static String? Function(String?) validateDiffChange(
    FormFieldState<String> field, [
    String? error,
  ]) {
    return (String? value) {
      value = harmonize(value);
      if (field.value != value) {
        return error ?? "Values don't match";
      }
      return null;
    };
  }

  static String harmonize(String? value) =>
      value == null ? '' : value.replaceAll(',', '').trim();

  static bool hasSpecialCharacter(String? value) {
    final res = harmonize(value);
    if (res.isEmpty) return false;
    const specialChars = "<>@!#\$%^&*()_+[]{}?:;|'\"\\,./~`-=";
    for (var i = 0; i < specialChars.length; i++) {
      if (res.contains(specialChars[i])) {
        return true;
      }
    }
    return false;
  }

  static bool hasMinCharacters(String? value, {int minLength = 8}) {
    if (harmonize(value).length < minLength) {
      return false;
    }
    return true;
  }

  static bool hasNumber(String? value) {
    if (harmonize(value).isEmpty) return false;
    const Pattern pattern = r'\d+';
    final regex = RegExp(pattern.toString());
    if (regex.hasMatch(harmonize(value))) return true;
    return false;
  }

  static bool hasUpperCase(String? value) {
    if (harmonize(value).isEmpty) return false;
    const Pattern pattern = '[A-Z]+';
    final regex = RegExp(pattern.toString());
    if (regex.hasMatch(harmonize(value))) return true;
    return false;
  }
}
