import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

Widget localContactWidget(
  BuildContext context,
  Contact contact,
) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: Insets.dim_12),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: AppColors.textHeaderColor,
        ),
      ),
    ),
    child: Row(
      children: [
        const XBox(Insets.dim_14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contact.displayName,
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.textHeaderColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.30,
              ),
            ),
            const YBox(Insets.dim_8),
            if (contact.phones.isNotEmpty)
              Text(
                contact.phones.first.number,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.textBodyColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  letterSpacing: 0.30,
                ),
              ),
            if (contact.emails.isNotEmpty)
              Text(
                contact.emails.first.address,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.textBodyColor,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  fontSize: 11,
                  letterSpacing: 0.30,
                ),
              ),
          ],
        )
      ],
    ),
  );
}

Widget remoteContactWidget(
  BuildContext context,
  ContactsModel contact,
) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: Insets.dim_12),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: AppColors.textHeaderColor,
        ),
      ),
    ),
    child: Row(
      children: [
        HostedImage(
          contact.avatar,
          height: Insets.dim_50,
          width: Insets.dim_50,
        ),
        const XBox(Insets.dim_14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contact.name,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.textHeaderColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 0.30,
                ),
              ),
              const YBox(Insets.dim_8),
              Text(
                contact.paymentId,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.textBodyColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  letterSpacing: 0.30,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
