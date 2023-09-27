import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/auth/auth.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:provider/provider.dart';

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox({
    super.key,
    this.title,
    this.descriptions,
    this.text,
    this.img,
    required this.contact,
    required this.amount,
  });
  final String? title, descriptions, text;
  final String? img;
  final String amount;
  final ContactsModel contact;

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Insets.dim_16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(
    BuildContext context,
  ) {
    final money = Money();
    final authP = context.watch<AuthProvider>();
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            left: Insets.dim_16,
            top: Insets.dim_64,
            right: Insets.dim_16,
            bottom: Insets.dim_16,
          ),
          margin: const EdgeInsets.only(top: Insets.dim_50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Insets.dim_16),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title ?? 'Transfer Confirmation',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.textHeaderColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  letterSpacing: 0.30,
                ),
              ),
              const YBox(Insets.dim_12),
              contentInfoWidget(
                context,
                leftTitle: 'From',
                leftDescriptions: authP.user.fullName,
                rightDescriptions: '**** 8456',
                rightTitle: 'Citibank Online',
              ),
              contentInfoWidget(
                context,
                leftTitle: 'To',
                leftDescriptions: widget.contact.name,
                rightDescriptions: widget.contact.paymentId,
                rightTitle: '',
              ),
              contentInfoWidget(
                context,
                leftTitle: '',
                leftDescriptions: 'Total',
                rightDescriptions:
                    money.formatValue(widget.amount.toInt() * 100),
                rightTitle: '',
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: AppButton(
                  action: () {
                    Navigator.of(context).pop(true);
                  },
                  textTitle: 'Ok, Send Now!',
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Insets.dim_20,
          right: Insets.dim_20,
          child: Container(
            padding: const EdgeInsets.all(Insets.dim_12),
            height: context.getHeight(0.1),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
              border: Border.all(width: 2, color: Colors.transparent),
              boxShadow: const [
                BoxShadow(
                  color: Colors.transparent,
                  blurRadius: 10,
                  spreadRadius: 10,
                )
              ],
            ),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.grey,
              ),
              child: HostedImage(
                widget.img ?? '',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column contentInfoWidget(
    BuildContext context, {
    String? leftTitle,
    String? leftDescriptions,
    String? rightTitle,
    String? rightDescriptions,
  }) {
    return Column(
      children: [
        const YBox(Insets.dim_12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leftTitle ?? 'From',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textBodyColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    letterSpacing: 0.30,
                  ),
                ),
                Text(
                  leftDescriptions ?? 'John',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textHeaderColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    letterSpacing: 0.30,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  rightTitle ?? 'Bank of America',
                  textAlign: TextAlign.end,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textBodyColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    letterSpacing: 0.30,
                  ),
                ),
                Text(
                  rightDescriptions ?? '**** 1121',
                  textAlign: TextAlign.end,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textHeaderColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        const YBox(Insets.dim_12),
        const Divider(),
      ],
    );
  }
}
