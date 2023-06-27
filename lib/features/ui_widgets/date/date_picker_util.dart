import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';

class DatePickerUtil {
  static void adaptive(
    BuildContext context, {
    required Function(DateTime) onDateTimeChanged,
    bool isDateOfBirth = false,
  }) {
    Platform.isIOS
        ? cupertinoDatePicker(
            context,
            onDateTimeChanged: onDateTimeChanged,
            isDOB: isDateOfBirth,
          )
        : androidDatePicker(
            context,
            onDateTimeChanged: onDateTimeChanged,
            isDOB: isDateOfBirth,
          );
  }

  static void cupertinoDatePicker(
    BuildContext context, {
    bool isDOB = true,
    required Function(DateTime) onDateTimeChanged,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        final currentDate = DateTime.now();
        final approvedAge = currentDate.year - 18;
        final newDate = DateTime(
          currentDate.year + 10,
          currentDate.month,
          currentDate.day,
        );
        final initialDate = DateTime(
          currentDate.year - 1,
          currentDate.month,
          currentDate.day,
        );
        return Container(
          height: 400.dy,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              SizedBox(
                height: 350.dy,
                child: CupertinoDatePicker(
                  minimumDate: !isDOB ? initialDate : DateTime(1947),
                  maximumDate: !isDOB ? newDate : DateTime(approvedAge),
                  initialDateTime:
                      !isDOB ? DateTime.now() : DateTime(approvedAge),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: onDateTimeChanged,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> androidDatePicker(
    BuildContext context, {
    bool isDOB = true,
    required Function(DateTime) onDateTimeChanged,
  }) async {
    final currentDate = DateTime.now();
    final approvedAge = currentDate.year - 18;

    final newDate = DateTime(
      currentDate.year + 10,
      currentDate.month,
      currentDate.day,
    );
    final firstDate = DateTime(
      currentDate.year - 1,
      currentDate.month,
      currentDate.day,
    );
    final dateTime = await showDatePicker(
      context: context,
      initialDate: !isDOB ? DateTime.now() : DateTime(approvedAge),
      firstDate: !isDOB ? firstDate : DateTime(1947),
      lastDate: !isDOB ? newDate : DateTime(approvedAge),
      keyboardType: TextInputType.datetime,
      builder: (_, __) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.borderColor,
            ),
          ),
          child: __!,
        );
      },
    );

    if (dateTime != null) {
      onDateTimeChanged(dateTime);
    }
  }
}
