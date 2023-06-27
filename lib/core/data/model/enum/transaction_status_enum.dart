import 'package:flutter/material.dart';

enum TransactionStatusEnum {
  pending, // => 0
  processing, //=>1
  successful, //=>2
  failed, //=>3
  cancelled, //=>4
  review, //=>5
}

extension TransactionStatusExtension on TransactionStatusEnum {
  String get name => describeEnum(this);

  String describeEnum(Object enumEntry) {
    final description = enumEntry.toString();
    final indexOfDot = description.indexOf('.');
    assert(indexOfDot != -1 && indexOfDot < description.length - 1, '');
    return description.substring(indexOfDot + 1);
  }

  String get displayTitle {
    switch (this) {
      case TransactionStatusEnum.pending:
        return 'Pending';
      case TransactionStatusEnum.processing:
        return 'Processing';
      case TransactionStatusEnum.successful:
        return 'Successful';
      case TransactionStatusEnum.failed:
        return 'Failed';
      case TransactionStatusEnum.cancelled:
        return 'Cancelled';
      case TransactionStatusEnum.review:
        return 'Review';
    }
  }

  Widget getStatusText(BuildContext context) {
    switch (this) {
      case TransactionStatusEnum.pending:
        return Text(
          'Pending',
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: const Color(0xffFF9500),
              ),
        );
      case TransactionStatusEnum.processing:
        return Text(
          'Processing',
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: const Color(0xffFF9500),
              ),
        );
      case TransactionStatusEnum.successful:
        return Text(
          'Success',
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: const Color(0xff00A32E),
              ),
        );
      case TransactionStatusEnum.failed:
        return Text(
          'Failed',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w400,
                color: const Color(0xffFF2D55),
              ),
        );
      case TransactionStatusEnum.review:
        return Text(
          'Review',
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: const Color(0xffFF9500),
              ),
        );
      case TransactionStatusEnum.cancelled:
        return Text(
          'Cancelled',
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: const Color(0xffFF9500),
              ),
        );
    }
  }
}
