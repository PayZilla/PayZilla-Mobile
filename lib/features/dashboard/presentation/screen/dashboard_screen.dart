import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/features/dashboard/dashboard.dart';
import 'package:pay_zilla/features/ui_widgets/ui_widgets.dart';

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
          const Align(
            alignment: Alignment(0, -0.4),
            child: AtmCardWidget(),
          )
        ],
      ),
    );
  }
}
