import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class SelectableContactWidget extends StatefulWidget {
  const SelectableContactWidget({
    super.key,
    required this.index,
    required this.isSelected,
  });
  final int index;
  final bool isSelected;

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
          color: widget.isSelected ? AppColors.appGreen : AppColors.borderColor,
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
              const Expanded(
                child: HostedImage(
                  'https://picsum.photos/200/300',
                  height: Insets.dim_100,
                  width: Insets.dim_100,
                ),
              ),
              const YBox(Insets.dim_16),
              Expanded(
                child: Text(
                  widget.index.isEven ? 'John Doe' : 'Harrison McKee Jnr.',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textHeaderColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
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
