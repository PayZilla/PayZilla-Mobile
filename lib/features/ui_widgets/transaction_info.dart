import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pay_zilla/functional_utils/notification_utility.dart';

class TransactionInfo extends StatelessWidget {
  const TransactionInfo({
    Key? key,
    this.description,
    this.value,
    this.showCopyWidget = false,
    this.isError = false,
  }) : super(key: key);

  final String? description, value;
  final bool showCopyWidget, isError;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          description!,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color(0xff6c7884),
              ),
        ),
        const Spacer(),
        Text(
          value!,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: isError ? Colors.red : const Color(0xff333D47),
                height: 1.33,
              ),
          textAlign: TextAlign.end,
        ),
        if (showCopyWidget)
          const SizedBox(
            width: 16,
          )
        else
          const SizedBox.shrink(),
        if (showCopyWidget)
          copyWidget(context, toCopy: value!)
        else
          const SizedBox.shrink(),
      ],
    );
  }

  Widget copyWidget(BuildContext context, {required String toCopy}) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: toCopy)).then((_) {
          showInfoNotification(context, '$toCopy copied to clipboard');
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffE7E5FA),
          borderRadius: BorderRadius.circular(4),
        ),
        width: 50,
        height: 32,
        alignment: Alignment.center,
        child: Text(
          'Copy',
          style: Theme.of(context).textTheme.labelSmall!.apply(
                color: Theme.of(context).primaryColor,
                fontWeightDelta: 2,
              ),
        ),
      ),
    );
  }
}
