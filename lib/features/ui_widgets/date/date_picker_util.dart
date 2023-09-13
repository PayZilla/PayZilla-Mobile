import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';

class DatePickerUtil {
  static Future<void> adaptive(
    BuildContext context, {
    required Function(DateTime) onDateTimeChanged,
    bool isDateOfBirth = false,
  }) async {
    if (Platform.isIOS) {
      final choosenDate = await cupertinoDatePicker(
        context,
        onDateTimeChanged: onDateTimeChanged,
        isDOB: isDateOfBirth,
      );
      onDateTimeChanged(choosenDate);
    } else {
      await androidDatePicker(
        context,
        onDateTimeChanged: onDateTimeChanged,
        isDOB: isDateOfBirth,
      );
    }
  }

  static Future<DateTime> cupertinoDatePicker(
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
    final initialDate = DateTime(
      currentDate.year - 1,
      currentDate.month,
      currentDate.day,
    );
    final initialDateTime = !isDOB ? DateTime.now() : DateTime(approvedAge);
    var choosenDate = initialDateTime.copyWith();
    await showCupertinoModalPopup(
      context: context,
      builder: (_) {
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
                  initialDateTime: initialDateTime,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (datePicked) {
                    choosenDate = datePicked;
                    onDateTimeChanged(datePicked);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
    return choosenDate;
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
    final initialDate = !isDOB ? DateTime.now() : DateTime(approvedAge);
    final dateTime = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: !isDOB ? firstDate : DateTime(1947),
      lastDate: !isDOB ? newDate : DateTime(approvedAge),
      keyboardType: TextInputType.datetime,
      builder: (_, __) {
        return Theme(
          data: ThemeData.light().copyWith(
            // ignore: prefer_const_constructors
            colorScheme: ColorScheme.light(
              primary: AppColors.btnPrimaryColor,
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
