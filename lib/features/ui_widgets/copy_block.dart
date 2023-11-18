import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pay_zilla/functional_utils/notification_utility.dart';

class CopyBlock extends StatelessWidget {
  const CopyBlock({
    Key? key,
    required this.context,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final BuildContext context;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: const Color(0xff6c7884),
                fontWeightDelta: 2,
              ),
          textAlign: TextAlign.start,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: const Color(0xff6c7884),
                ),
            textAlign: TextAlign.start,
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: subTitle)).then((_) {
              showInfoNotification(context, '$title copied to clipboard');
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
        ),
      ),
    );
  }
}
