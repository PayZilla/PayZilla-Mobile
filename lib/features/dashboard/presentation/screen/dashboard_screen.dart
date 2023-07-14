import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';
import 'package:pay_zilla/functional_utils/extensions/context_extension.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      useBodyPadding: false,
      body: Stack(
        children: [
          Stack(
            fit: StackFit.expand,
            children: [
              FractionallySizedBox(
                heightFactor: .4,
                alignment: Alignment.topCenter,
                child: Container(
                  color: AppColors.black,
                ),
              ),
              FractionallySizedBox(
                heightFactor: .6,
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: AppColors.borderErrorColor,
                ),
              ),
            ],
          ),
          Align(
            alignment: const Alignment(0, -0.4),
            child: Container(
              height: context.getHeight(0.2),
              width: context.getWidth(0.9),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: Corners.mdBorder,
              ),
            ),
          )
        ],
      ),
    );
  }
}
