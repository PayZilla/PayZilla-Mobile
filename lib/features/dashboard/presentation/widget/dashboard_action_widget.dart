import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

class DashboardIconActionWidget extends StatelessWidget {
  const DashboardIconActionWidget({
    super.key,
    required this.icon,
    required this.name,
    required this.todo,
    this.length = 4,
  });

  final List<String> icon;
  final List<String> name;
  final List<Function()> todo;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.getHeight(.09),
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.dim_22,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: Insets.dim_22,
      ),
      decoration: BoxDecoration(
        borderRadius: Corners.mdBorder,
        color: AppColors.borderColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: todo[index],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LocalSvgImage(icon[index]),
                  const YBox(Insets.dim_12),
                  Flexible(
                    child: Text(
                      name[index],
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textHeaderColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: 0.30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ).toList(),
      ),
    );
  }
}
