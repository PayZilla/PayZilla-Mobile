import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class SelectableContactWidget extends StatefulWidget {
  const SelectableContactWidget({
    super.key,
    required this.index,
    required this.isSelected,
    required this.contact,
  });
  final int index;
  final bool isSelected;
  final Contact contact;

  @override
  State<SelectableContactWidget> createState() =>
      _SelectableContactWidgetState();
}

class _SelectableContactWidgetState extends State<SelectableContactWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(0.4),
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.dim_16,
        vertical: Insets.dim_12,
      ),
      decoration: BoxDecoration(
        borderRadius: Corners.mdBorder,
        border: Border.all(
          color: widget.isSelected
              ? AppColors.appGreen
              : AppColors.black.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const YBox(Insets.dim_26),
              Expanded(
                child: CircleAvatar(
                  backgroundColor: AppColors.btnPrimaryColor,
                  radius: Insets.dim_116,
                  child: widget.contact.photoOrThumbnail != null
                      ? Image.memory(widget.contact.photoOrThumbnail!)
                      : const Icon(
                          Icons.person_add_alt,
                          size: Insets.dim_30,
                        ),
                ),
              ),
              const YBox(Insets.dim_16),
              Expanded(
                child: Text(
                  widget.contact.displayName,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textHeaderColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 0.30,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  widget.contact.phones.isNotEmpty
                      ? widget.contact.phones.first.number
                      : '',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textBodyColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: 0.30,
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: widget.isSelected,
            child: const Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.check_rounded,
                color: AppColors.appGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
